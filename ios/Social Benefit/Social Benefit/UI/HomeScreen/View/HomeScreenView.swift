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
    @ObservedObject var homeViewModel = HomeViewModel()
    
    @EnvironmentObject var monitor: NetworkMonitor
    
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
                BuyVoucherPopUp(isPresentPopUp: $confirmInforBuyViewModel.isPresentedPopup)
                OtherPopUpView()
                
                // User - Customer support popup...
                CustomerSupportPopUp()
                
                // Banner Screen
                
                InternalNewDetailNavigationView(internalNews: homeViewModel.selectedInternalNew, isPresent: homeViewModel.isPresentInternalNewDetail)
                
                MerchantVoucherDetailNavigationView(voucherId: homeViewModel.selectedVoucherId, isPresent: homeViewModel.isPresentVoucherDetail)

            }
            .alert(isPresented: $monitor.isPresentPopUp, content: {
                return Alert(title: Text("No Internet Connection"), message: Text("Please enable Wifi or Celluar data"), dismissButton: .default(Text("Cancel")))
            })
            .navigationBarHidden(true)
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
        .environmentObject(homeViewModel)
    }
    
    @ViewBuilder func getView(selectedTab: String) -> some View {
        switch selectedTab {
        case "house":
            HomeView()
        case "star":
            Rectangle().fill(Color.white)
        case "tag":
            ListOfMerchantView().frame(width: ScreenInfor().screenWidth)
        default:
            UserView()
        }
    }
    
    @ViewBuilder
    func InternalNewDetailNavigationView(internalNews: InternalNewsData?,  isPresent: Bool) -> some View {
        if isPresent {
            VStack {
                if let internalNews = internalNews {
                    InternalNewsDetailView(internalNewData: internalNews, isHiddenTabBarWhenBack: false, isNavigationFromHomeScreen: true)
                        .background(Color.white)
                }
            }
        }
    }

    @ViewBuilder
    func MerchantVoucherDetailNavigationView(voucherId: Int?,  isPresent: Bool) -> some View {
        if isPresent {
            VStack {
                if let voucherId = voucherId {
                    MerchantVoucherDetailView(isNavigationFromHomeScreen: true, voucherId: voucherId)
                        .background(Color.white)
                }
            }
        }
    }
}

struct HomeScreenTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
