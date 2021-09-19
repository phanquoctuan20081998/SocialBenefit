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
    
    @State var isActive = false
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Spacer().frame(height: 25)
                SearchBarAndMyVoucherView()
                MerchantCategoryItemView(isActive: $isActive)
                ScrollView {
                    SpecialOffersView()
                    FilterView()
                    AllOffersView()
                }
            }.navigationBarHidden(true)
            .background(BackgroundView())
            .background(
                NavigationLink(
                    destination: ListOfMerchantViewByCategory(isActive: $isActive).navigationBarHidden(true),
                    isActive: $isActive,
                    label: {
                        EmptyView()
                    })
                    
            )
        }
        .overlay(OtherPopUpView(isActive: $isActive))
        .environmentObject(specialOffersViewModel)
        .environmentObject(merchantCategoryItemViewModel)
        .environmentObject(offersViewModel)
    }
}

struct ListOfMerchantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}
