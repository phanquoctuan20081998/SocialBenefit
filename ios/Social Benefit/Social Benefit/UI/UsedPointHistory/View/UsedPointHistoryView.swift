//
//  UsedPointHistoryView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/11/2021.
//

import SwiftUI
import Network

struct UsedPointHistoryView: View {
    
    @ObservedObject var usedPointHistoryViewModel = UsedPointHistoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 50)
            UpperView
            TransactionView
        }
    }
}

extension UsedPointHistoryView {
    
    var UpperView: some View {
        VStack {
            
            Text("your_used_points_hictory".localized.uppercased())
                .bold()
                .foregroundColor(Color.blue)
            
            SearchBarView(searchText: $usedPointHistoryViewModel.searchText, isSearching: $usedPointHistoryViewModel.isSearch, placeHolder: "search_the_transaction".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: true)
            
            HeaderTab
        }
    }
    
    var HeaderTab: some View {
        let header = ["all", "received", "consummed"]
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
        ScrollView {
            VStack {
                
                ForEach(usedPointHistoryViewModel.allUsedPointsHistoryData.indices, id:\.self) { index in
                    
                    if usedPointHistoryViewModel.sameDateGroup.contains(index) {
                        Text(usedPointHistoryViewModel.dateHistoryName[index])
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .offset(y: 20))
                    }
                    
                    TransactionCardView(transactionType: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mAction,
                                        time: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mTime,
                                        sourceName: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mDestination,
                                        point: usedPointHistoryViewModel.allUsedPointsHistoryData[index].mPoint)
                    
                    if usedPointHistoryViewModel.sameDateGroup.contains(index + 1) {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                    }
                }
            }
        }
        .frame(width: ScreenInfor().screenWidth)
        .background(Color("nissho_light_blue"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct UsedPointHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UsedPointHistoryView()
    }
}
