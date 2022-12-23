//
//  AddView.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 04/10/22.
//

import SwiftUI
import ToastSwiftUI
import Combine

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: AddMarkPresenter
    var idBookMark: Int = 0
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if presenter.isLoading {
                    
                } else if presenter.isError {
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        imageUpload
                            .background(.yellow)
                            .cornerRadius(16)
                        Spacer()
                            .frame(height: 20)
                        VStack(alignment: .leading, spacing: 2)  {
                            HStack {
                                Text("Judul")
                                    .font(.system(size: 21))
                                    .bold()
                                    .lineLimit(1)
                                    .frame(width: 100, alignment: .leading)
                                TextField("Judul buku...", text: $presenter.booktitle)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .padding(.vertical, 8)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(4)
                            
                            HStack {
                                Text("Halaman Terakhir")
                                    .font(.system(size: 21))
                                    .bold()
                                    .lineLimit(2)
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", text: $presenter.lastPage)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 80, alignment: .leading)
                                    .padding(.vertical, 8)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(4)
                            Spacer()
                                .frame(height: 30)
                            HStack {
                                Text("Detail Data")
                                    .font(.system(size: 21))
                                    .bold()
                                    .lineLimit(2)
                                    .foregroundColor(.gray)
                            }
                            HStack {
                                Text("Total Halaman")
                                    .font(.system(size: 21))
                                    .bold()
                                    .lineLimit(2)
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", text: $presenter.totalPage)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 80, alignment: .leading)
                                    .padding(.vertical, 8)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(4)
                            HStack {
                                Text("Penulis")
                                    .font(.system(size: 21))
                                    .bold()
                                    .frame(width: 100, alignment: .leading)
                                TextField("Tulis nama penulis...", text: $presenter.author)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .padding(.vertical, 8)
                                    .textFieldStyle(.roundedBorder)
                            }
                            .padding(4)
                        }
                        
                        .padding(.horizontal, 16)
                        
                    }
                    
                }
                
            }
            .onAppear {
                if idBookMark > 0 {
                    self.presenter.detailBookMark(id: idBookMark)
                }
            }
            .popup(isPresenting: $presenter.isPresentingPopup, popup: ToastView(message: idBookMark > 0 ? "Success Update Bookmark" : "Success Menambahkan Bookmark", icon: .info)
                .cornerRadius(16)
                .frame(width: UIScreen.main.bounds.width - 32, height: 150)
            )
            .onReceive(NotificationCenter.default.publisher(for: .dismissAdd), perform: { _ in
                presentationMode.wrappedValue.dismiss()
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        if idBookMark > 0 {
                            presenter.updateBookMark(id: idBookMark)
                        } else {
                            presenter.addBookMark()
                        }
                    }, label: {
                        let textSave = idBookMark > 0 ? "Update" : "Save"
                        Text(textSave)
                            .font(.system(size: 21))
                            .foregroundColor(.gray)
                            .bold()
                            .padding(.trailing, 4)
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        let leftButton = presenter.leftButton
                        Text(leftButton)
                            .font(.system(size: 21))
                            .foregroundColor(.gray)
                            .bold()
                            .padding(.trailing, 4)
                    })
                }
                
            }
        }
    }
    
    var imageUpload: some View {
        VStack {
            
        }
        .padding(20)
        .frame(width: UIScreen.main.bounds.width - 32, height: 300)
        
    }
}
