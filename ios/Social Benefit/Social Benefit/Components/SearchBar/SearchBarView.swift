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
    
    var width: CGFloat
    var height: CGFloat
    var fontSize: CGFloat
    var isShowCancelButton: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField(placeHolder, text: $searchText)
                    .padding(.leading, 35)
                    .font(.system(size: CGFloat(fontSize)))
                    .frame(height: CGFloat(height))
            }
            .padding(.all, 7)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
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
                                .font(.system(size: CGFloat(fontSize)))
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal, 13)
                .foregroundColor(.gray)
            )
//            .transition(.move(edge: .trailing))
//            .animation(.spring())
        
            if isSearching && isShowCancelButton {
                Spacer().frame(width: 15)
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("cancel".localized)
                        .font(.system(size: CGFloat(fontSize)))
                })
                .transition(.move(edge: .trailing))
                .animation(.easeInOut(duration: 0.1))
            }
        }.padding(.vertical, 5)
        .frame(width: CGFloat(width), alignment: .leading)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""), isSearching: .constant(true), placeHolder: "search_news".localized, width: 400, height: 30, fontSize: 13, isShowCancelButton: true)
                .previewLayout(.sizeThatFits)
            SearchBarView(searchText: .constant(""), isSearching: .constant(false), placeHolder: "search_news".localized, width: 400, height: 30, fontSize: 13, isShowCancelButton: true)
                .previewLayout(.sizeThatFits)
        }
    }
}
