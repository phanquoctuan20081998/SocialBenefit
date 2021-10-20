//
//  HomeView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 90)

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
            }
            .background(BackgroundViewWithNotiAndSearch())
            .edgesIgnoringSafeArea(.all)
                        
            InternalNewDetailNavigationView(internalNews: homeViewModel.selectedInternalNew, isPresent: homeViewModel.isPresentInternalNewDetail)
            
            MerchantVoucherDetailNavigationView(voucherId: homeViewModel.selectedVoucherId, isPresent: homeViewModel.isPresentVoucherDetail)
            
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
