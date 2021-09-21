//
//  HomeScreenTabBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var internalNewsViewModel = InternalNewsViewModel()
    
    @State var selectedTab = "house"
    @State var isPresentedTabBar = true
    
    var body: some View {
      
        ZStack(alignment: .bottom) {
            getView(selectedTab: selectedTab)
            // Custom Tab Bar
            if isPresentedTabBar {
                CustomTabBarView(selectedTab: $selectedTab)
            }
        }
        .environmentObject(internalNewsViewModel)
    }
    
    @ViewBuilder func getView(selectedTab: String) -> some View {
        switch selectedTab {
        case "house":
            HomeView(isPresentedTabBar: $isPresentedTabBar)
        case "star":
            EmptyView()
        case "tag":
            ListOfMerchantView()
        default:
            UserView(isPresentedTabBar: $isPresentedTabBar)
        }
//        if selectedTab == "house" {
//            return
//        } else if selectedTab == "star" {
//            return
//        } else if selectedTab == "tag" {
//            return ListOfMerchantView()
//        } else {
//            return UserView(isPresentedTabBar: $isPresentedTabBar)
//        }
    }
}

struct HomeView: View {
    
    @Binding var isPresentedTabBar: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 70)
                
                ScrollView {
                    VStack(spacing: 30) {
                        MainCardView()
                        InternalNewsBannerView(isPresentedTabBar: $isPresentedTabBar)
                        RecognitionsBannerView(isPresentedTabBar: $isPresentedTabBar)
                        PromotionsBannerView(isPresentedTabBar: $isPresentedTabBar)
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }.background(
                BackgroundView()
            ).navigationBarHidden(true)
        }
    }
}
struct HomeScreenTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
