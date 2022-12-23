//
//  BookMarkerApp.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 12/09/22.
//

import SwiftUI

@main
struct BookMarkerApp: App {
    var body: some Scene {
        WindowGroup {
            let listBookMarkUseCase = Injection.init().provideGetListBookMark()
            let deleteBookMarkUseCase = Injection.init().provideDeleteMark()
            let updateLastPageUseCase = Injection.init().provideUpdateLastPage()
            
            let homePresenter = HomePresenter(
                listBookMarkUseCase: listBookMarkUseCase,
                deleteBookMarkUseCase: deleteBookMarkUseCase,
                updateLastPageUseCase: updateLastPageUseCase
            )
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
