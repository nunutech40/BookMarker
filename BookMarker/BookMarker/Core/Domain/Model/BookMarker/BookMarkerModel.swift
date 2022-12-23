//
//  BookMarkerModel.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//

import Foundation

struct BookMarkerModel {
    let id: Int
    let title: String
    let lastPage: Int
    var author: String = ""
    var totalPage: Int = 0
    var thumbImage: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var createAt: String = ""
    var updateAt: String = ""
}
