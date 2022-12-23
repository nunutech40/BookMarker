//
//  BookMarkerEntity.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 05/10/22.
//

import RealmSwift

class BookMarkerEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var author = ""
    @objc dynamic var lastPage = 0
    @objc dynamic var totalPage = 0
    @objc dynamic var thumbImage = ""
    @objc dynamic var startDate = ""
    @objc dynamic var endDate = ""
    @objc dynamic var createAt = ""
    @objc dynamic var updateAt = ""
    //@objc dynamic var isArchived = false
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    func IncrementaID() -> Int {
        let realm = try! Realm()
        if let primaryId = realm.objects(BookMarkerEntity.self).sorted(byKeyPath: "id", ascending: false).first?.id {
            return primaryId + 1
        }else{
            return 1
        }
    }
    
}
