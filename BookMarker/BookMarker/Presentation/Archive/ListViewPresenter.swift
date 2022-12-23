//
//  ListViewPresenter.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 29/10/22.
//

import Foundation

class ListViewPresenter: ObservableObject {
    
    var listBookMarks: [BookMarkerModel] = []
    
    func setupData() {
        
        let bookMarker1 = BookMarkerModel(
            id: 1,
            title: "Psycology Of Moneuyddddd",
            lastPage: 111,
            thumbImage: "https://d33wubrfki0l68.cloudfront.net/df5cad897615eb9978c7e1fe94bb231b44de4d35/c891d/images/posts/psychology-of-money.jpg"
        )
        
        for i in 0...4 {
            listBookMarks.append(bookMarker1)
        }
        
    }
    
}
