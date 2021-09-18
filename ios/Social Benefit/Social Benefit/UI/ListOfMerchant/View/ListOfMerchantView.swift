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
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer().frame(height: 20)
            SearchBarAndMyVoucherView()
            MerchantCategoryItemView()
            ScrollView {
                SpecialOffersView()
                FilterView()
                AllOffersView()
            }
            
            
            
        }.background(BackgroundView())
        .overlay(OtherPopUpView())
        .environmentObject(specialOffersViewModel)
        .environmentObject(merchantCategoryItemViewModel)
        .environmentObject(offersViewModel)
    }
}

struct ListOfMerchantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
        //            .environmentObject(MerchantVoucherSpecialListViewModel())
        //            .environmentObject(MerchantCategoryItemViewModel())
        //            .environmentObject(MerchantVoucherListByCategoryViewModel())
    }
}
