//
//  ListOfMerchantView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI

struct ListOfMerchantView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    @ObservedObject var merchantVoucherDetailViewModel = MerchantVoucherDetailViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 15) {
                    Spacer().frame(height: 25)
                    SearchBarAndMyVoucherView()
                    MerchantCategoryItemView()
                    ScrollView {
                        SpecialOffersView()
                        FilterView()
                        AllOffersView()
                    }
                }.navigationBarHidden(true)
                .background(BackgroundViewWithNotiAndSearch())
                
            }.if(confirmInforBuyViewModel.isPresentedError, transform: { view in
                view.overlay(ErrorMessageView(error: confirmInforBuyViewModel.buyVoucherResponse.errorCode, isPresentedError: $confirmInforBuyViewModel.isPresentedError))
            })
        }.environmentObject(merchantVoucherDetailViewModel)
    }
}

struct ListOfMerchantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
            .environmentObject(InternalNewsViewModel())
            .environmentObject(MerchantVoucherSpecialListViewModel())
            .environmentObject(MerchantCategoryItemViewModel())
            .environmentObject(MerchantVoucherListByCategoryViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
    }
}
