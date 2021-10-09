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
    @ObservedObject var searchViewModel = SearchViewModel()
    
    init(selectedTab: String) {
        homeScreenViewModel.selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                
                getView(selectedTab: homeScreenViewModel.selectedTab)
                
                // Search View...
                SearchView(isPresent: $homeScreenViewModel.isPresentedSearchView, searchText: $searchViewModel.searchText, isSearching: $searchViewModel.isSearching, contentView: AnyView(SearchContentView()))
                
                // Custom Tab Bar...
                if homeScreenViewModel.isPresentedTabBar {
                    CustomTabBarView(selectedTab: $homeScreenViewModel.selectedTab)
                }

                // Promotion - Buy Button and Other Category popup...
                BuyVoucherPopUp()
                OtherPopUpView()
                
                // User - Customer support popup...
                CustomerSupportPopUp()

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
        .environmentObject(searchViewModel)
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

struct HomeScreenTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
