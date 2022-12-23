//
//  UpdateMarkerOfABook.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Combine

protocol UpdateMarkerUseCase {
    func updateMarkerBook(id: Int, bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error>
}

class UpdateMarkerOfBookInteractor: UpdateMarkerUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func updateMarkerBook(id: Int, bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error> {
        self.repository.updateBookMarkerById(by: id, bookMarker: bookMarker)
    }
}
