//
//  ListOfMerchantView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI

struct ListOfMerchantView: View {
    
    @ObservedObject var specialOffersViewModel = SpecialOffersViewModel()
    @ObservedObject var merchantCategoryItemViewModel = MerchantCategoryItemViewModel()
    
    @State var isSearching = false
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBarView
                MerchantCategoryItemView()
                SpecialOffersView()
                FilterView()
                AllOffersView()
            }
            .environmentObject(specialOffersViewModel)
            .environmentObject(merchantCategoryItemViewModel)
        }
    }
}

extension ListOfMerchantView {
    private var SearchBarView: some View {
        HStack {
            HStack {
                TextField("", text: $specialOffersViewModel.searchPattern)
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
                        Button(action: { specialOffersViewModel.searchPattern = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
        }.padding(.vertical, 5)
    }
}

struct ListOfMerchantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}
