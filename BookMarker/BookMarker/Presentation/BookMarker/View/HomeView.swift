//
//  HomeView.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 17/09/22.
//

import SwiftUI
import ToastSwiftUI
import Foundation

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    @State private var showDetails = false
    @State var updatePageView = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if presenter.isLoading {
                    loadingIndicator
                } else if presenter.isError {
                    errorIndicator
                } else if presenter.listBookMarkerState.isEmpty {
                    emptyCategories
                }
                else {
                    // load view here
                    hightLightView
                        .background(.blue)
                        .cornerRadius(16)
                    List {
                        Section(
                            header: Text("Marker Buku Yang Kamu Baca"),
                            footer: Text("Lihat Archive")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    
                                }
                        ) {
                            ForEach(
                                self.presenter.listBookMarkerState,
                                id: \.id
                            ) { bookMark in
                                ZStack {
                                    BookRow(bookMarker: bookMark)
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                self.deleteTap()
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
                                        self.presenter.bookMarkHightlight = bookMark
                                        self.presenter.setHightLihgt()
                                        self.updatePageView = true
                                    }
                                    .onLongPressGesture {
                                        print("hehehe")
                                    }
                            }
                        }
                    }
                    
                    
                }
            }
            .navigationTitle("Highlight")
            .toolbar {
                Button(action: {presenter.toAddView()}, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                            .padding(.leading, 4)
                        Text("New")
                            .foregroundColor(.white)
                            .padding(.trailing, 4)
                    }
                    .frame(width: 80, height: 40)
                })
                .background(.gray)
                .cornerRadius(16)
            }
            .onAppear {
                self.presenter.getListBookMarker()
            }
            .onReceive(NotificationCenter.default.publisher(for: .dismissAdd), perform: { _ in
                self.presenter.getListBookMarker()
            })
            .alert("Update Mark", isPresented: $updatePageView, actions: {
                
                TextField("0", text: $presenter.lastPageState)
                
                Button("Simpan Mark", action: {
                    self.presenter.updateLastPage(id: self.presenter.bookMarkHightlight?.id ?? 0)
                })
            }, message: {
                let data = self.presenter.bookMarkHightlight
                
                Text("Halam Terakhir dari buku \(data?.title ?? "")")
                    .font(.system(size: 20))
                    .bold()
                    .lineLimit(1)
            })
            
        }
        
    }
}

extension HomeView {
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Add some mark from book you reading..."
        ).offset(y: 80)
    }
    
    var hightLightView: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Menu {
                Button(action: {
                    editTap()
                }) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(action: {
                    deleteTap()
                }) {
                    Label("Delete", systemImage: "minus.circle")
                }
            } label: {
                Image("ellipsis-svgrepo-com")
                    .font(.largeTitle)
                    .padding(.top, 8)
                    .padding(.trailing, 4)
                    .frame(width: 50, height: 24)
            }
            
            VStack {
                let data = self.presenter.bookMarkHightlight
                HStack {
                    Text("Last page \(data?.lastPage ?? 0)")
                        .font(.system(size: 20))
                        .bold()
                        .lineLimit(1)
                }
                Text("\(data?.title ?? "no title")")
                    .font(.system(size: 24))
                    .bold()
                    .lineLimit(1)
                    .padding(.bottom, 8)
            }
            .padding(20)
            .frame(width: UIScreen.main.bounds.width - 32, height: 200)
            
        }
        
    }
}

extension HomeView {
    
    func editTap() {
        self.presenter.editToAddView()
    }
    
    func deleteTap() {
        self.presenter.deleteBookMark(id: self.presenter.bookMarkHightlight?.id ?? 0)
    }
}
