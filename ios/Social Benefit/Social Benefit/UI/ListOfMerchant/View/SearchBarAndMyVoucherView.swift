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
            
            NavigationLink(destination: MyVoucherView().navigationBarHidden(true),
                           tag: 2,
                           selection: $merchantCategoryItemViewModel.selection,
                           label: {
                            HStack() {
                                Image("ic_my_voucher")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 27)
                                
                                Text("my_voucher".localized)
                                    .font(.system(size: 9))
                                    .frame(width: 40)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 7)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                            .onTapGesture {
                                self.merchantCategoryItemViewModel.selection = 2
                            }
                           })
            
            
        }.padding(.horizontal, 10)
    }
}

struct SearchBarAndMyVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}
