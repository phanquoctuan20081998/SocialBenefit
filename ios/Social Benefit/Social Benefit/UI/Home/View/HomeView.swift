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
                Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        MainCardView(personalPoint: homeViewModel.walletInfor.getPersonalPoint())
                            .padding()
                        
                        if isDisplayFunction(Constants.FuctionId.INTERNAL_NEWS) {
                            InternalNewsBannerView()
                        }
                        
                        if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                            RecognitionsBannerView()
                            PromotionsBannerView()
                        }
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }
            .background(BackgroundViewWithNotiAndSearch())
            .edgesIgnoringSafeArea(.all)
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
