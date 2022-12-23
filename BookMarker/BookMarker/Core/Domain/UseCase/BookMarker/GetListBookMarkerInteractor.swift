//
//  GetListBookMarker.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Combine

protocol GetListBookMarkUseCase {
    func getListBookMarked() -> AnyPublisher<[BookMarkerModel], Error>
}

class GetListBookMarkerInteractor: GetListBookMarkUseCase {
    
    private let repository: BookMarkerRepository
    
    required init(repository: BookMarkerRepository) {
        self.repository = repository
    }
    
    func getListBookMarked() -> AnyPublisher<[BookMarkerModel], Error> {
        self.repository.getListBookMarkers()
    }
}
