//
//  BookRow.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 12/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookRow: View {
    var bookMarker: BookMarkerModel
    
    var body: some View {
        
        HStack {
            bookImage
                .background(Color.gray)
                .cornerRadius(16)
            content
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}

extension BookRow {
    
    var bookImage: some View {
        WebImage(url: URL(string: bookMarker.thumbImage))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 85, height: 120)
            .cornerRadius(2)
    }
    
    var content: some View {
        VStack {
            HStack(spacing: 8) {
                VStack(alignment: .leading) {
                    Text(bookMarker.title)
                        .font(.system(size: 20))
                        .bold()
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text(String("Last update"))
                        .font(.system(size: 11))
                    
                    Text("Jumat, 12 September 2022")
                        .font(.system(size: 14))
                }
                contenPage
            }
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.gray)
                .padding(.horizontal, 12)
                .frame(height: 16)
        }
        
    }
    
    var contenPage: some View {
        VStack {
            ZStack {
                Text(String(bookMarker.lastPage))
                    .font(.system(size: 21))
                    .lineLimit(1)
            }
            .frame(width: 40, height: 40)
            .cornerRadius(8)
            Text(String("Last Page"))
                .font(.system(size: 12))
                .padding(.bottom, 4)
        }
        .scaledToFill()
    }
    
}



struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        let bookMarker = BookMarkerModel(
            id: 1,
            title: "Psycology Of Moneuyddddd",
            lastPage: 111,
            thumbImage: "https://d33wubrfki0l68.cloudfront.net/df5cad897615eb9978c7e1fe94bb231b44de4d35/c891d/images/posts/psychology-of-money.jpg"
        )
        BookRow(bookMarker: bookMarker)
    }
}


