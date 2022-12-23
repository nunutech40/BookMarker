//
//  HomePresenter.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 07/10/22.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private var listBookMarkerUseCase: GetListBookMarkUseCase
    private var deleteBookMarkUseCase: DeleteMarkUseCase
    private var updateLastPageUseCase: UpdateLastPageUseCase
    private let router = BookMarkerRouter()
    
    init(
        listBookMarkUseCase: GetListBookMarkUseCase,
        deleteBookMarkUseCase: DeleteMarkUseCase,
        updateLastPageUseCase: UpdateLastPageUseCase
    ) {
        self.listBookMarkerUseCase = listBookMarkUseCase
        self.deleteBookMarkUseCase = deleteBookMarkUseCase
        self.updateLastPageUseCase = updateLastPageUseCase
    }
    
    // usecase value state
    @Published var listBookMarkerState: [BookMarkerModel] = []
    @Published var lastPageState: String = ""
    @Published var deleteState: Bool = false
    
    // state
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var dataReceived: Bool = false
    @Published var bookMarkHightlight: BookMarkerModel?
    
    func setHightLihgt() {
        self.lastPageState = "\(self.bookMarkHightlight?.lastPage ?? 0)"
    }
    
    func getListBookMarker() {
        isLoading = true
        self.listBookMarkerUseCase.getListBookMarked()
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
            }, receiveValue: { listBookMarks in
                self.listBookMarkerState = listBookMarks
                if !self.listBookMarkerState.isEmpty {
                    self.bookMarkHightlight = self.listBookMarkerState[0]
                    self.lastPageState = "\(self.bookMarkHightlight?.lastPage ?? 0)"
                }
            })
            .store(in: &cancellables)
    }
    
    func deleteBookMark(id: Int) {
        isLoading = true
        self.deleteBookMarkUseCase.deleteMarkerBook(id: id)
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
            }, receiveValue: { statusDelete in
                self.deleteState = statusDelete
                if (statusDelete) {
                    self.getListBookMarker()
                }
            })
            .store(in: &cancellables)
    }
    
    func updateLastPage(id: Int) {
        isLoading = true
        self.updateLastPageUseCase.upateLastPage(by: id, lastPage: Int(lastPageState) ?? 0)
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
            }, receiveValue: { state in
                if (state) {
                    self.getListBookMarker()
                }
            })
            .store(in: &cancellables)
    }
    
}

extension HomePresenter {
    
    func toAddView() {
        router.toAddView(addView: makeAddView(isEdit: false))
    }
    
    func editToAddView() {
        router.toAddView(addView: makeAddView(isEdit: true))
    }
    
    func toListArchive() {
        
    }
    
    private func makeAddView(isEdit: Bool) -> AddView {
        let addMarkUseCase = Injection.init().provideAddMark()
        let detailBookMarkUseCase = Injection.init().provideDetailBookMark()
        let editBookMarkUseCase = Injection.init().provideUpdateMark()
        
        let presenter = AddMarkPresenter(
            addBookMarkUseCase: addMarkUseCase,
            detailBookMarkUseCase: detailBookMarkUseCase,
            editBookMarkUseCase: editBookMarkUseCase
        )
        var addView = AddView(presenter: presenter)
        if isEdit {
            addView.idBookMark = self.bookMarkHightlight?.id ?? 0
        }
        return addView
    }
}

