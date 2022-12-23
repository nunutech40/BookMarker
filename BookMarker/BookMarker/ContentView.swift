//
//  ContentView.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 12/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        HomeView(presenter: homePresenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
