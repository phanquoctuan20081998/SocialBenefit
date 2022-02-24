//
//  UsedPointHistoryView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/11/2021.
//

import SwiftUI
import Network
import SwiftyJSON

struct UsedPointHistoryView: View {
    
    @ObservedObject var usedPointHistoryViewModel = UsedPointHistoryViewModel()
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    //Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
            UpperView
            
            if usedPointHistoryViewModel.isLoading && !usedPointHistoryViewModel.isRefreshing {
                LoadingPageView()
                    .frame(width: ScreenInfor().screenWidth)
                    .background(Color("nissho_light_blue"))
                    .edgesIgnoringSafeArea(.all)
            } else {
                TransactionView
            }
        }
        .background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "your_used_points_hictory".localized, isHaveLogo: true))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension UsedPointHistoryView {
    
    var UpperView: some View {
        VStack (spacing: 20) {
                        
            SearchBarView(searchText: $usedPointHistoryViewModel.searchText, isSearching: $usedPointHistoryViewModel.isSearch, placeHolder: "search_the_transaction".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: true)
            
            HeaderTab
        }
    }
    
    var HeaderTab: some View {
        let header = ["all", "received", "consumed"]
        return HStack(spacing: 0) {
            ForEach(header.indices, id: \.self) { index in
                Text(header[index].localized)
                    .frame(width: ScreenInfor().screenWidth / CGFloat(header.count), height: 40)
                    .background(
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(usedPointHistoryViewModel.selectedTab == index ? Color("nissho_light_blue") : Color("nissho_blue"), lineWidth: 1)
                                .background(RoundedRectangle(cornerRadius: 6).fill(usedPointHistoryViewModel.selectedTab == index ? Color("nissho_light_blue") : Color.white))
                            
                            if usedPointHistoryViewModel.selectedTab == index {
                                Rectangle()
                                    .frame(width: ScreenInfor().screenWidth / CGFloat(header.count) * 0.8, height: 1)
                                    .foregroundColor(Color.gray)
                            }
                        }
                    )
                    .onTapGesture {
                        usedPointHistoryViewModel.selectedTab = index
                    }
            }
        }
    }
    
    var TransactionView: some View {
        RefreshableScrollView(height: 70, refreshing: self.$usedPointHistoryViewModel.isRefreshing) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(usedPointHistoryViewModel.sameDateGroup.indices, id:\.self) { i in
                        
                        Text(usedPointHistoryViewModel.sameDateGroup[i].date)
                            .bold()
                            .font(.system(size: 14))
                            .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
                            .padding(.vertical)
                        
                        let item = usedPointHistoryViewModel.sameDateGroup[i]
                        
                        VStack {
                            ForEach(item.head ..< item.tail + 1, id:\.self) { index in
                                TransactionCardView(transactionType: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mAction, time: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mTime, sourceName: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mDestination, point: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mPoint)
                                
                                // Display separate line except for last one
                                if index != item.tail {
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white))
                    }
                    
                    
                    //Infinite Scroll View
                    
                    if (usedPointHistoryViewModel.fromIndex == usedPointHistoryViewModel.allUsedPointsHistoryData.count && self.isShowProgressView) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                
                                // Because the maximum length of the result returned from the API is 10...
                                // So if length % 10 != 0 will be the last queue...
                                // We only send request if it have more data to load...
                                if self.usedPointHistoryViewModel.allUsedPointsHistoryData.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.usedPointHistoryViewModel.reload()
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
                            
                            if !usedPointHistoryViewModel.allUsedPointsHistoryData.isEmpty && minY < height && usedPointHistoryViewModel.allUsedPointsHistoryData.count >= Constants.MAX_NUM_API_LOAD  {
                                
                                DispatchQueue.main.async {
                                    usedPointHistoryViewModel.fromIndex = usedPointHistoryViewModel.allUsedPointsHistoryData.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                    
                    Spacer().frame(height: 50)
                }
            }
        }.frame(width: ScreenInfor().screenWidth)
            .background(Color("nissho_light_blue"))
            .edgesIgnoringSafeArea(.all)
    }
}

struct UsedPointHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UsedPointHistoryView()
            .environmentObject(HomeScreenViewModel())
    }
}
