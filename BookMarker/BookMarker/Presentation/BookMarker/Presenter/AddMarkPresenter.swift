//
//  AddMarkPresenter.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 08/10/22.
//

import Foundation
import Combine
import SwiftUI

class AddMarkPresenter: ObservableObject {
    
    private var addBookMarkUseCase: AddBookMarkUseCase
    private var detailBookMarkUseCase: DetailBookMarkUseCase
    private var editBookMarkUseCase: UpdateMarkerUseCase
    
    private var cancellables: Set<AnyCancellable> = []
    
    // var publised input
    @Published var booktitle: String = ""
    @Published var lastPage: String = ""
    @Published var totalPage: String = ""
    @Published var author: String = ""
    
    // var published value state
    @Published var addBookMarkState: Bool = false
    @Published var detailBookMarkState: BookMarkerModel?
    @Published var updateBookMarkState: Bool = false
    
    // var publised state
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var isPresentingPopup: Bool = false
    @Published var leftButton: String = "Cancel"
    
    init(
        addBookMarkUseCase: AddBookMarkUseCase,
        detailBookMarkUseCase: DetailBookMarkUseCase,
        editBookMarkUseCase: UpdateMarkerUseCase
    ) {
        self.addBookMarkUseCase = addBookMarkUseCase
        self.detailBookMarkUseCase = detailBookMarkUseCase
        self.editBookMarkUseCase = editBookMarkUseCase
    }
    
    func popUpSetting() {
        self.isPresentingPopup = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isPresentingPopup = false
            self.leftButton = "Done"
            self.clearInput()
        }
    }
    
    func clearInput() {
        self.booktitle = ""
        self.lastPage = ""
        self.totalPage = ""
        self.author = ""
        NotificationCenter.default.post(name: .dismissAdd, object: true)
    }
    
    func setupDataDetail() {
        let data = detailBookMarkState
        self.booktitle = data?.title ?? ""
        self.lastPage = "\(data?.lastPage ?? 0)"
        self.totalPage = "\(data?.totalPage ?? 0)"
        self.author = data?.author ?? ""
    }
    
    func addBookMark() {
        let intLastPage = Int(lastPage)
        let intTotalPage = Int(totalPage)
        
        let bookMarkModel = BookMarkerModel(
            id: -1000,
            title: booktitle,
            lastPage: intLastPage ?? 0,
            author: author,
            totalPage: intTotalPage ?? 0
        )
        
        addBookMarkUseCase.addMarkerBook(bookMarker: bookMarkModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            },
                  receiveValue: { statusAdd in
                self.addBookMarkState = statusAdd
                self.popUpSetting()
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
    
    func updateBookMark(id: Int) {
        print("cek update bookmark id: \(id)")
        let intLastPage = Int(lastPage)
        let intTotalPage = Int(totalPage)
        
        let bookMarkModel = BookMarkerModel(
            id: -1000,
            title: booktitle,
            lastPage: intLastPage ?? 0,
            author: author,
            totalPage: intTotalPage ?? 0
        )
        
        editBookMarkUseCase.updateMarkerBook(id: id, bookMarker: bookMarkModel)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            },
                  receiveValue: { updateStatus in
                self.updateBookMarkState = updateStatus
                self.popUpSetting()
                self.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
    
    func detailBookMark(id: Int) {
        isLoading = true
        self.detailBookMarkUseCase.getDataBookMarkedById(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { detailBookMark in
                self.detailBookMarkState = detailBookMark
                self.setupDataDetail()
            })
            .store(in: &cancellables)
    }
}
