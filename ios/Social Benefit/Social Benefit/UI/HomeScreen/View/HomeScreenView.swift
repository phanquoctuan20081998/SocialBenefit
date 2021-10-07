//
//  HomeScreenTabBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var internalNewsViewModel = InternalNewsViewModel()
    @ObservedObject var merchantCategoryItemViewModel = MerchantCategoryItemViewModel()
    @ObservedObject var specialOffersViewModel = MerchantVoucherSpecialListViewModel()
    @ObservedObject var offersViewModel = MerchantVoucherListByCategoryViewModel()
    @ObservedObject var confirmInforBuyViewModel = ConfirmInforBuyViewModel()
    @ObservedObject var homeScreenViewModel = HomeScreenViewModel()
    @ObservedObject var merchantVoucherDetailViewModel = MerchantVoucherDetailViewModel()
    @ObservedObject var customerSupportViewModel = CustomerSupportViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                
                getView(selectedTab: homeScreenViewModel.selectedTab)
                
                // Custom Tab Bar
                if homeScreenViewModel.isPresentedTabBar {
                    CustomTabBarView(selectedTab: $homeScreenViewModel.selectedTab)
                }
                
                
                // Promotion - Buy Button and Other Category popup...
                BuyVoucherPopUp()
                OtherPopUpView()
                
                // User - Customer support popup...
                //            NavigationView {
                CustomerSupportPopUp()
                //            }
            }.navigationBarHidden(true)
        }
        
        .environmentObject(internalNewsViewModel)
        .environmentObject(specialOffersViewModel)
        .environmentObject(merchantCategoryItemViewModel)
        .environmentObject(offersViewModel)
        .environmentObject(confirmInforBuyViewModel)
        .environmentObject(homeScreenViewModel)
        .environmentObject(merchantVoucherDetailViewModel)
        .environmentObject(customerSupportViewModel)
    }
    
    @ViewBuilder func getView(selectedTab: String) -> some View {
        switch selectedTab {
        case "house":
            HomeView()
        case "star":
            Rectangle().fill(Color.white)
        case "tag":
            ListOfMerchantView()
        default:
            UserView()
        }
    }
}

struct HomeView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 40)
                
                ScrollView {
                    VStack(spacing: 20) {
                        MainCardView()
                            .padding(.top, 10)
                        InternalNewsBannerView()
                        RecognitionsBannerView()
                        PromotionsBannerView()
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }.background(
                BackgroundViewWithNotiAndSearch()
            ).navigationBarHidden(true)
        }
    }
}
struct HomeScreenTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
