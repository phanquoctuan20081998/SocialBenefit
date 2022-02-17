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
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    var body: some View { 
        VStack(spacing: 15) {
            
            Spacer().frame(height: ScreenInfor().screenHeight * 0.05)
            SearchBarAndMyVoucherView()
            MerchantCategoryItemView()
            
            if (specialOffersViewModel.isLoading || offersViewModel.isLoading) && !(specialOffersViewModel.isRefreshing || offersViewModel.isRefreshing) {
                LoadingPageView()
            } else {
                let binding = Binding<Bool>(
                    get: {
                        self.specialOffersViewModel.isRefreshing && self.offersViewModel.isRefreshing && self.merchantCategoryItemViewModel.isRefreshing
                    },
                    
                    set: {
                        self.specialOffersViewModel.isRefreshing = $0
                        self.offersViewModel.isRefreshing = $0
                        self.merchantCategoryItemViewModel.isRefreshing = $0
                    })
                
                    RefreshableScrollView(height: 70, refreshing: binding) {
                        SpecialOffersView()
                        FilterView()
                        AllOffersView()
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
            
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
        }
        .background(BackgroundViewWithNotiAndSearch(), alignment: .top)
        .overlay(ErrorMessageView(error: confirmInforBuyViewModel.buyVoucherResponse.errorCode, isPresentedError: $confirmInforBuyViewModel.isPresentedError))
        .onAppear {
            homeScreenViewModel.isPresentedTabBar = true
        }
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
