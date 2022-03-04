//
//  RankingOfRecognitionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 27/11/2021.
//

import SwiftUI

struct RankingOfRecognitionView: View {
    
    @ObservedObject var rankingOfRecognitionViewModel = RankingOfRecognitionViewModel()
    @EnvironmentObject var recognitionViewModel: RecognitionViewModel
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 70)
            RankingCardView(isHaveTopTitle: false, allowTapAvatar: true)
                .padding(.bottom, 20)
            VStack {
                RankingView
                Spacer()
                MyRankView
            }.background(Color("nissho_light_blue").opacity(0.7))
        }
        .environmentObject(recognitionViewModel)
        .edgesIgnoringSafeArea(.all)
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "ranking_of_the_month".localized, isHaveLogo: true))
    }
}

extension RankingOfRecognitionView {
    
    var RankingView: some View {
        VStack {
            HeaderView
            RefreshableScrollView(height: 70, refreshing: self.$rankingOfRecognitionViewModel.isRefreshing) {
                ForEach(rankingOfRecognitionViewModel.allRankingList.indices, id: \.self) { index in
                    
                    NavigationLink {
                        NavigationLazyView(EmployeeRankingView(employeeId: rankingOfRecognitionViewModel.allRankingList[index].getId()))
                    } label: {
                        rankingCardView(rankingCard: rankingOfRecognitionViewModel.allRankingList[index])
                            .foregroundColor(.black)
                    }
    
                    Rectangle()
                        .frame(width: ScreenInfor().screenWidth * 0.95, height: 1)
                        .foregroundColor(.gray.opacity(0.5))
                }
                
                //Infinite Scroll View
                
                if (rankingOfRecognitionViewModel.fromIndex == rankingOfRecognitionViewModel.allRankingList.count && isShowProgressView) {
                    
                    ActivityIndicator(isAnimating: true)
                        .onAppear {
                            
                            // Because the maximum length of the result returned from the API is 10...
                            // So if length % 10 != 0 will be the last queue...
                            // We only send request if it have more data to load...
                            if rankingOfRecognitionViewModel.allRankingList.count % Constants.MAX_NUM_API_LOAD == 0 {
                                self.rankingOfRecognitionViewModel.reloadData()
                            }
                            
                            // Otherwise just delete the ProgressView after 1 seconds...
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isShowProgressView = false
                            }
                            
                        }
                    
                } else {
                    GeometryReader { reader -> Color in
                        let minY = reader.frame(in: .global).minY
                        let height = ScreenInfor().screenHeight / 1.3
                        
                        if !rankingOfRecognitionViewModel.allRankingList.isEmpty && minY < height && rankingOfRecognitionViewModel.allRankingList.count >= Constants.MAX_NUM_API_LOAD  {
                            
                            DispatchQueue.main.async {
                                rankingOfRecognitionViewModel.fromIndex = rankingOfRecognitionViewModel.allRankingList.count
                                self.isShowProgressView = true
                            }
                        }
                        return Color.clear
                    }
                    .frame(width: 20, height: 20)
                }
            }
        }
    }
    
    var HeaderView: some View {
        HStack {
            Text("rank".localized)
                .frame(width: ScreenInfor().screenWidth / 5, alignment: .center)
            Text("employee".localized)
                .frame(width: ScreenInfor().screenWidth / 2.3, alignment: .center)
            Text("total_received_points".localized)
                .frame(width: ScreenInfor().screenWidth / 4, alignment: .center)
        }
        .font(.system(size: 15))
        .multilineTextAlignment(.center)
        .padding()
        .background(Color("nissho_blue"))
        .frame(width: ScreenInfor().screenWidth)
    }
    
    var MyRankView: some View {
        VStack {
            HStack {
                Text("\("your_rank".localized): \(rankingOfRecognitionViewModel.myRank.getRank())")
                Spacer()
                Text("\("total_received_points".localized): \(rankingOfRecognitionViewModel.myRank.getTotalScore())")
            }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            
            Spacer().frame(height: 20)
        }
        .background(Rectangle().fill(Color("nissho_blue")))
        .font(.system(size: 15))
    }
    
    @ViewBuilder
    func rankingCardView(rankingCard: RankingOfRecognitionData) -> some View {
        HStack(spacing: 0) {
            ZStack {
                Top3Mark(top: rankingCard.getRank())
                    .scaledToFit()
                    .frame(height: 25)
                    .offset(y: 3)
                Text("\(rankingCard.getRank())")
                    .font(.system(size: 14))
            }
            .frame(width: ScreenInfor().screenWidth / 5, alignment: .center)
            
            Spacer()
            
            Text(rankingCard.getEmployeeName())
                .font(.system(size: 14))
                .frame(width: ScreenInfor().screenWidth / 2.3, alignment: .center)
            
            Spacer()
            
            Text("\(rankingCard.getTotalScore())")
                .font(.system(size: 14))
                .padding(.trailing, 10)
                .frame(width: ScreenInfor().screenWidth / 4, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .frame(height: 35)
    }
    
    @ViewBuilder
    func Top3Mark(top: Int) -> some View {
        if top == 1 {
            Image(systemName: "bookmark.fill")
                .resizable()
                .foregroundColor(Color("color_top1"))
        } else if top == 2 {
            Image(systemName: "bookmark.fill")
                .resizable()
                .foregroundColor(Color("color_top2"))
        } else if top == 3 {
            Image(systemName: "bookmark.fill")
                .resizable()
                .foregroundColor(Color("color_top3"))
        } else {
            EmptyView()
        }
    }
}

struct RankingOfRecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        RankingOfRecognitionView()
            .environmentObject(RecognitionViewModel())
    }
}
