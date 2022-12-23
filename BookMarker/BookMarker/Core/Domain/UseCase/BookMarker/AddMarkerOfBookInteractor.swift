//
//  AddMarkerOfBook.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Combine

protocol AddBookMarkUseCase {
    func addMarkerBook(bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error>
}

class AddMarkerOfBookInteractor: AddBookMarkUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func addMarkerBook(bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error> {
        self.repository.saveBookMark(from: bookMarker)
    }
}
