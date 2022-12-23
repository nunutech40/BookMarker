//
//  BookMarkerMapper.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 06/10/22.
//


final class BookMarkerMapper {
    
    static func mapBookMarkerEntitiesToDomain(
      input bookMarkerEntities: [BookMarkerEntity]
    ) -> [BookMarkerModel] {
      return bookMarkerEntities.map { result in
        return BookMarkerModel(
            id: result.id,
            title: result.title,
            lastPage: result.lastPage,
            author: result.author,
            totalPage: result.totalPage,
            thumbImage: result.thumbImage,
            startDate: result.startDate,
            endDate: result.endDate,
            createAt: result.createAt,
            updateAt: result.updateAt
        )
      }
    }
    
    static func mapBookMarkerEntityToDomain(
      input bookMarkerEntity: BookMarkerEntity
    ) -> BookMarkerModel {
        return BookMarkerModel(
            id: bookMarkerEntity.id,
            title: bookMarkerEntity.title,
            lastPage: bookMarkerEntity.lastPage,
            author: bookMarkerEntity.author,
            totalPage: bookMarkerEntity.totalPage,
            thumbImage: bookMarkerEntity.thumbImage,
            startDate: bookMarkerEntity.startDate,
            endDate: bookMarkerEntity.endDate,
            createAt: bookMarkerEntity.createAt,
            updateAt: bookMarkerEntity.updateAt
        )
    }

    
    static func mapBookMarkerDomainToEntity(
        input bookMarker: BookMarkerModel
    ) -> BookMarkerEntity {
        let newEntity = BookMarkerEntity()
        newEntity.id = bookMarker.id
        newEntity.title = bookMarker.title
        newEntity.lastPage = bookMarker.lastPage
        newEntity.author = bookMarker.author
        newEntity.totalPage = bookMarker.totalPage
        newEntity.thumbImage = bookMarker.thumbImage
        newEntity.startDate = bookMarker.startDate
        newEntity.endDate = bookMarker.endDate
        newEntity.createAt = bookMarker.createAt
        newEntity.updateAt = bookMarker.updateAt
        return newEntity
    }

    
}
