//
//  HomeView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
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
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
