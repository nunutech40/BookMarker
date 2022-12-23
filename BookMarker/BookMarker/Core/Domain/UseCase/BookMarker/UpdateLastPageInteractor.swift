//
//  UpdateLastPageUseCase.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 13/10/22.
//

import Combine

protocol UpdateLastPageUseCase {
    func upateLastPage(by id: Int, lastPage: Int) -> AnyPublisher<Bool, Error>
}

class UpdateLastPagekInteractor: UpdateLastPageUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func upateLastPage(by id: Int, lastPage: Int) -> AnyPublisher<Bool, Error> {
        self.repository.updateLastPageByid(by: id, lastPage: lastPage)
    }
}

