//
//  SearchBarAndMyVoucherView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/09/2021.
//

import SwiftUI

// To remember the last search
var tempSearchText = ""
var tempIsSearching = false

struct SearchBarAndMyVoucherView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    @State var searchText = tempSearchText
    @State var isSearching = tempIsSearching
    
    var body: some View {
        SearchBarView
    }
}

extension SearchBarAndMyVoucherView {
    
    private var SearchBarView: some View {
        
        let binding = Binding<String>(get: { self.searchText },
                                      set: {
                                        self.searchText = $0
                                        tempSearchText = $0
                                        self.specialOffersViewModel.searchPattern = $0
                                        self.offersViewModel.searchPattern = $0
                                      })

        return HStack {
            HStack {
                TextField("search_voucher".localized, text: binding)
                    .font(.system(size: 15))
                    .padding(.leading, 35)
            }
            .padding(.all, 5)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
            .onTapGesture(perform: {
                isSearching = true
                tempIsSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: {
                            self.searchText = ""
                            tempSearchText = ""
                            
                            self.isSearching = false
                            tempIsSearching = false
                            
                            self.specialOffersViewModel.searchPattern = ""
                            self.offersViewModel.searchPattern = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal, 10)
                .foregroundColor(.gray)
            )
            
            MyVoucherButtonView()
            
        }.padding(.horizontal, 10)
    }
}

struct SearchBarAndMyVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
