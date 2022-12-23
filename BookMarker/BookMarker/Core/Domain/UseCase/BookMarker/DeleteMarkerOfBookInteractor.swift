//
//  DeleteMarkerOfABook.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Combine

protocol DeleteMarkUseCase {
    func deleteMarkerBook(id: Int) -> AnyPublisher<Bool, Error>
}

class DeleteMarkerOfBookInteractor: DeleteMarkUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func deleteMarkerBook(id: Int) -> AnyPublisher<Bool, Error> {
        self.repository.deleteBookMarkerById(by: id)
    }
}
