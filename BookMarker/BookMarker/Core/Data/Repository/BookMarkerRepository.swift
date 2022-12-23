//
//  BookMarkerRepository.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 05/10/22.
//

import Foundation
import Combine

protocol BookMarkerRepositoryProtocol {
    func saveBookMark(from bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error>
    func getListBookMarkers() -> AnyPublisher<[BookMarkerModel], Error>
    func getBookMarkerById(by id: Int) -> AnyPublisher<BookMarkerModel, Error>
    func updateBookMarkerById(by id: Int, bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error>
    func deleteBookMarkerById(by id: Int) -> AnyPublisher<Bool, Error>
    func updateLastPageByid(by id: Int, lastPage: Int) -> AnyPublisher<Bool, Error>
}

final class BookMarkerRepository: NSObject {
    
    typealias BookMarkerInstance = (BookMarkerLocalDataSource) -> BookMarkerRepository
    
    fileprivate let locale: BookMarkerLocalDataSource
    
    private init(locale: BookMarkerLocalDataSource) {
        self.locale = locale
    }
    
    static let sharedInstance: BookMarkerInstance = { localDS in
        BookMarkerRepository(locale: localDS)
    }
    
}

extension BookMarkerRepository: BookMarkerRepositoryProtocol {
    
    func saveBookMark(from bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error> {
        let bookMarkerEntity = BookMarkerMapper.mapBookMarkerDomainToEntity(input: bookMarker)
        return self.locale.saveBookMark(from: bookMarkerEntity)
            .eraseToAnyPublisher()
    }
    
    func getListBookMarkers() -> AnyPublisher<[BookMarkerModel], Error> {
        return self.locale.getListBookMarkers()
            .map { BookMarkerMapper.mapBookMarkerEntitiesToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getBookMarkerById(by id: Int) -> AnyPublisher<BookMarkerModel, Error> {
        return self.locale.getBookMarkerById(by: id)
            .map { BookMarkerMapper.mapBookMarkerEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateBookMarkerById(by id: Int, bookMarker: BookMarkerModel) -> AnyPublisher<Bool, Error> {
        let bookMarkerEntity = BookMarkerMapper.mapBookMarkerDomainToEntity(input: bookMarker)
        return self.locale.updateBookMarkerById(by: id, bookMarker: bookMarkerEntity)
            .eraseToAnyPublisher()
    }
    
    func deleteBookMarkerById(by id: Int) -> AnyPublisher<Bool, Error> {
        self.locale.deleteBookMarkerById(by: id)
            .eraseToAnyPublisher()
    }
    
    func updateLastPageByid(by id: Int, lastPage: Int) -> AnyPublisher<Bool, Error> {
        self.locale.updateLastPageById(by: id, lastPage: lastPage)
            .eraseToAnyPublisher()
    }
    
}
