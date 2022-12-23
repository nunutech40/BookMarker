//
//  Injection.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 07/10/22.
//

import RealmSwift

final class Injection: NSObject {
    
    // provide bookmark repository
    private func provideRepositoryBookMarker() -> BookMarkerRepository {
        let realm = try? Realm()
        
        let locale: BookMarkerLocalDataSource = BookMarkerLocalDataSource.sharedInstance(realm)
        
        return BookMarkerRepository.sharedInstance(locale)
    }
    
    func provideAddMark() -> AddBookMarkUseCase {
        let repository = provideRepositoryBookMarker()
        return AddMarkerOfBookInteractor(repository: repository)
    }
    
    func provideDeleteMark() -> DeleteMarkUseCase {
        let repository = provideRepositoryBookMarker()
        return DeleteMarkerOfBookInteractor(repository: repository)
    }
    
    func provideUpdateMark() -> UpdateMarkerUseCase {
        let repository = provideRepositoryBookMarker()
        return UpdateMarkerOfBookInteractor(repository: repository)
    }
    
    func provideGetListBookMark() -> GetListBookMarkUseCase {
        let repository = provideRepositoryBookMarker()
        return GetListBookMarkerInteractor(repository: repository)
    }
    
    func provideDetailBookMark() -> DetailBookMarkUseCase {
        let repository = provideRepositoryBookMarker()
        return DetailBookMarkedInteractor(repository: repository)
    }
    
    func provideUpdateLastPage() -> UpdateLastPageUseCase {
        let repository = provideRepositoryBookMarker()
        return UpdateLastPagekInteractor(repository: repository)
    }
    
}
