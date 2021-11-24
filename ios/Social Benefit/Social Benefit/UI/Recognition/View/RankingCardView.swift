//
//  RankingCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import SwiftUI

struct RankingCardView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                TopTitleView(title: "recognitions_ranking".localized, topTitleTapped: topTitledTapped, isSeeAll: false)
                    .font(.system(size: 14, weight: .heavy))
                    .foregroundColor(.blue)
                
                Rectangle()
                    .frame(width: ScreenInfor().screenWidth * 0.9, height: 2)
                    .foregroundColor(Color.blue.opacity(0.2))
                    .padding(.leading)
            }
            
            Spacer().frame(height: 20)
            
            RankingBackgroud
        }
    }
}

extension RankingCardView {
    
    var RankingBackgroud: some View {
        ZStack(alignment: .bottom) {
            Image("bg_ranking")
                .resizable()
            
            Image("rank_block")
                .resizable()
                .scaledToFit()
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 150)
            
            ImageFrame(rank: 1)
            ImageFrame(rank: 2)
            ImageFrame(rank: 3)
        }
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        .frame(width: ScreenInfor().screenWidth * 0.93, height: 150, alignment: .bottom)
    }
    
    @ViewBuilder
    func ImageFrame(rank: Int) -> some View {
        
        if rank == 1 {
            Image("pic_user_profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                .padding(.all, 7)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("color_top1"), lineWidth: 3))
                .offset(x: 0, y: -60)
                .overlay(
                    Image("ic_medal_gold")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .offset(x: 30, y: -40)
                )
        } else if rank == 2 {
            Image("pic_user_profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 45, height: 45)
                .padding(.all, 7)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("color_top2"), lineWidth: 3))
                .offset(x: -100, y: -40)
                .overlay(
                    Image("ic_medal_sliver")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: -80, y: -20)
                )
        } else if rank == 3 {
            Image("pic_user_profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 45, height: 45)
                .padding(.all, 7)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("color_top3"), lineWidth: 3))
                .offset(x: 100, y: -40)
                .overlay(
                    Image("ic_medal_brass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: 125, y: -20)
                )
        }
    }
    
    func topTitledTapped() {
        
    }
}

struct RankingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RankingCardView()
    }
}
