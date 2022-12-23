//
//  BookMarkerDataSource.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 05/10/22.
//

import Foundation
import RealmSwift
import Combine

protocol BookMarkerDataLocaleProtocol: class {
    func saveBookMark(from bookMarker: BookMarkerEntity) -> AnyPublisher<Bool, Error>
    func getListBookMarkers() -> AnyPublisher<[BookMarkerEntity], Error>
    func getBookMarkerById(by id: Int) -> AnyPublisher<BookMarkerEntity, Error>
    func updateBookMarkerById(by id: Int, bookMarker: BookMarkerEntity) -> AnyPublisher<Bool, Error>
    func deleteBookMarkerById(by id: Int) -> AnyPublisher<Bool, Error>
}

final class BookMarkerLocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> BookMarkerLocalDataSource = { realmDB in
        return BookMarkerLocalDataSource(realm: realmDB)
    }
}

extension BookMarkerLocalDataSource: BookMarkerDataLocaleProtocol {
    
    
    
    func saveBookMark(from bookMarker: BookMarkerEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        if (bookMarker.id < 0) {
                            bookMarker.id = BookMarkerEntity().IncrementaID()
                        }
                        realm.add(bookMarker)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getListBookMarkers() -> AnyPublisher<[BookMarkerEntity], Error> {
        return Future<[BookMarkerEntity], Error> { completion in
            if let realm = self.realm {
                let bookMarkers: Results<BookMarkerEntity> = {
                    realm.objects(BookMarkerEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                completion(.success(bookMarkers.toArray(ofType: BookMarkerEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getBookMarkerById(by id: Int) -> AnyPublisher<BookMarkerEntity, Error> {
        return Future<BookMarkerEntity, Error> { completion in
            if let realm = self.realm {
                
                let meals: Results<BookMarkerEntity> = {
                    realm.objects(BookMarkerEntity.self)
                        .filter("id = \(id)")
                }()
                
                guard let meal = meals.first else {
                    completion(.failure(DatabaseError.requestFailed))
                    return
                }
                completion(.success(meal))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateLastPageById(by id: Int, lastPage: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let bookMarkerEntity = {
                realm.objects(BookMarkerEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try realm.write {
                        bookMarkerEntity.lastPage = lastPage
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateBookMarkerById(by id: Int, bookMarker: BookMarkerEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let bookMarkerEntity = {
                realm.objects(BookMarkerEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try realm.write {
                        bookMarkerEntity.title = bookMarker.title
                        bookMarkerEntity.author = bookMarker.author
                        bookMarkerEntity.lastPage = bookMarker.lastPage
                        bookMarkerEntity.totalPage = bookMarker.totalPage
                        bookMarkerEntity.thumbImage = bookMarker.thumbImage
                        bookMarkerEntity.startDate = bookMarker.startDate
                        bookMarkerEntity.endDate = bookMarker.endDate
                        bookMarkerEntity.updateAt = bookMarker.updateAt
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteBookMarkerById(by id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm, let bookMarkerEntity = {
                realm.objects(BookMarkerEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try realm.write {
                        realm.delete(bookMarkerEntity)
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    
}

