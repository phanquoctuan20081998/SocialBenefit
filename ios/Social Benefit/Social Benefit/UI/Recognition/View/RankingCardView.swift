//
//  RankingCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import SwiftUI

struct RankingCardView: View {
    
    @EnvironmentObject var recognitionViewModel: RecognitionViewModel
    var isHaveTopTitle = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            if isHaveTopTitle {
                VStack(alignment: .leading, spacing: 0) {
                    
                    TopTitleView(title: "recognitions_ranking".localized, topTitleTapped: topTitledTapped, isSeeAll: false)
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.blue)
                    
                    Rectangle()
                        .frame(width: ScreenInfor().screenWidth * 0.9, height: 2)
                        .foregroundColor(Color.blue.opacity(0.2))
                        .padding(.leading)
                }.padding(.horizontal, 20)
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
            
            RankingOfMonthView
                .padding(.bottom, 135)
            
            ImageFrame(rank: 1)
            ImageFrame(rank: 2)
            ImageFrame(rank: 3)
        }
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        .frame(width: ScreenInfor().screenWidth * 0.93, height: 190, alignment: .bottom)
    }
    
    @ViewBuilder
    func ImageFrame(rank: Int) -> some View {
        
        if rank == 1 && recognitionViewModel.top3Recognition.count >= 1 {
            VStack(spacing: 5) {
                URLImageView(url: recognitionViewModel.top3Recognition[0].avatar)
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(.all, 7)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("color_top1"), lineWidth: 3))
                
                    .overlay(
                        Image("ic_medal_gold")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .offset(x: 30, y: 20)
                    )
                
                Text(recognitionViewModel.top3Recognition[0].name)
                    .font(.system(size: 18, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: 80, height: 20)
            }.offset(x: 0, y: -40)
        } else if rank == 2 && recognitionViewModel.top3Recognition.count >= 2 {
            VStack(spacing: 5) {
                URLImageView(url: recognitionViewModel.top3Recognition[1].avatar)
                    .clipShape(Circle())
                    .frame(width: 45, height: 45)
                    .padding(.all, 7)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("color_top2"), lineWidth: 3))
                
                    .overlay(
                        Image("ic_medal_sliver")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(x: 30, y: 16)
                    )
                
                Text(recognitionViewModel.top3Recognition[1].name)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: 80, height: 20)
            }.offset(x: -120, y: -20)
        } else if rank == 3 && recognitionViewModel.top3Recognition.count >= 3 {
            VStack(spacing: 5) {
                URLImageView(url: recognitionViewModel.top3Recognition[2].avatar)
                    .clipShape(Circle())
                    .frame(width: 45, height: 45)
                    .padding(.all, 7)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("color_top3"), lineWidth: 3))
                    .overlay(
                        Image("ic_medal_brass")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(x: 30, y: 16)
                    )
                Text(recognitionViewModel.top3Recognition[2].name)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(width: 80, height: 20)
            }
            .offset(x: 120, y: -20)
        }
    }
    
    func topTitledTapped() {
        
    }
    
    var RankingOfMonthView: some View {
        ZStack {
            let curMonth = Calendar.current.dateComponents([.month], from: Date()).month
            
            Image("rankingribbon")
                .resizable()
                .frame(width: 270, height: 50)
            
//            Text(String(format: NSLocalizedString("startCustom %.1f", comment: ""),
//                        self.customDistance)
            Text("ranking_of_month %@".localizeWithFormat(arguments: getMonthEnlishFormat(month: curMonth ?? 0)).uppercased())
                .bold()
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.bottom, 3)
        }
    }
}

struct RankingCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionView()
    }
}
