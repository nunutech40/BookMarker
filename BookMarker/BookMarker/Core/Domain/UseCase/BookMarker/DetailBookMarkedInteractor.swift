//
//  DetailBookMarked.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Combine

protocol DetailBookMarkUseCase {
    func getDataBookMarkedById(id: Int) -> AnyPublisher<BookMarkerModel, Error>
}

class DetailBookMarkedInteractor: DetailBookMarkUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func getDataBookMarkedById(id: Int) -> AnyPublisher<BookMarkerModel, Error> {
        self.repository.getBookMarkerById(by: id)
    }
}
