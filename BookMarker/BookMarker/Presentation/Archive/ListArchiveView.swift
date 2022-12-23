//
//  ListArchiveView.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 29/10/22.
//

import SwiftUI

struct ListArchiveView: View {
    
    var viewModel: ListViewPresenter
    
    init(viewModel: ListViewPresenter) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        List {
            ForEach(
                viewModel.listBookMarks,
                id: \.id
            ) { bookMark in
                ZStack {
                    BookRow(bookMarker: bookMark)
                        .swipeActions(edge: .leading) {
                            Button {
                                //self.deleteTap()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                print("Archived")
                            } label: {
                                Label("Archived", systemImage: "archivebox")
                            }
                        }
                    
                }.padding(8)
                    .onTapGesture {
                        
                    }
                    .onLongPressGesture {
                        print("hehehe")
                    }
            }
        }
        .onAppear {
            
        }
    }
}
