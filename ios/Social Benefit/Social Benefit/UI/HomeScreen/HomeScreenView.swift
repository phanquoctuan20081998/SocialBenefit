//
//  HomeScreenTabBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var internalNewsViewModel = InternalNewsViewModel()
    @State var isPresentedTabBar = true
    @State var offset: CGFloat = 0
    
    var body: some View {

        GeometryReader { proxy in
            ScrollableTabBar(tabs: tabs, rect: proxy.frame(in: .global), offset: $offset) {
                HStack(spacing: 0 ){
                    HomeView(isPresentedTabBar: $isPresentedTabBar)
                    Rectangle().fill(Color.white)
                    ListOfMerchantView()
                    UserView(isPresentedTabBar: $isPresentedTabBar)
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .environmentObject(internalNewsViewModel)
        .overlay(CustomTabBarView(offset: $offset),
                 alignment: .bottom)
        .edgesIgnoringSafeArea(.all)
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
            }
            
            .background(
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
