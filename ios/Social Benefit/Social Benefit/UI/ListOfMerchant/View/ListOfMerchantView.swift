//
//  ListOfMerchantView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI

struct ListOfMerchantView: View {
    
    @ObservedObject var merchantCategoryItemViewModel = MerchantCategoryItemViewModel()
    @ObservedObject var specialOffersViewModel = MerchantVoucherSpecialListViewModel()
    @ObservedObject var offersViewModel = MerchantVoucherListByCategoryViewModel()
    
    @State var isSearching = false
    @State var searchText = ""
    
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
            .environmentObject(offersViewModel)
        }
    }
}

extension ListOfMerchantView {
    private var SearchBarView: some View {
        
        let binding = Binding<String>(get: { self.searchText },
                                      set: {
                                        self.searchText = $0
                                        self.specialOffersViewModel.searchPattern = $0
                                        self.offersViewModel.searchPattern = $0
                                      })

        return HStack {
            HStack {
                TextField("", text: binding)
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
                        Button(action: {
                            self.searchText = ""
                            self.specialOffersViewModel.searchPattern = ""
                            self.offersViewModel.searchPattern = ""
                        }, label: {
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
