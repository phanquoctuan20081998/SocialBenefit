//
//  SearchBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 31/08/2021.
//

import Foundation
import SwiftUI
import UIKit

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var placeHolder: String
    
    var body: some View {
        HStack {
            HStack {
                TextField(placeHolder, text: $searchText)
                    .padding(.leading, 35)
            }
            .padding(.all, 10)
            .background(Color(.systemGray5))
            .cornerRadius(20)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                        
                    }
                    
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("cancel".localized)
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }.padding(.vertical, 5)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""), isSearching: .constant(true), placeHolder: "search_news".localized)
                .previewLayout(.sizeThatFits)
            SearchBarView(searchText: .constant(""), isSearching: .constant(false), placeHolder: "search_news".localized)
                .previewLayout(.sizeThatFits)
        }
    }
}
