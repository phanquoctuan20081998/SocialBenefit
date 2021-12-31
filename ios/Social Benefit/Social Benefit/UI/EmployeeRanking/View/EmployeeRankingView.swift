//
//  EmployeeRankingView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/11/2021.
//

import SwiftUI
import ScrollViewProxy

struct EmployeeRankingView: View {
    
    @ObservedObject var employeeRankingViewModel: EmployeeRankingViewModel
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    init(employeeId: Int) {
        self.employeeRankingViewModel = EmployeeRankingViewModel(employeeId: employeeId)
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.13)
            EmployeeInforView
            Spacer()
            RefreshableScrollView(height: 70, refreshing: self.$employeeRankingViewModel.isRefreshing) {
                AmzdScrollViewReader { proxy in
                    VStack (spacing: 30) {
                        EmployeeListView
                    }
                }
            }.padding(.top)
            Spacer()
        }
        
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "employee_rank".localized, isHaveLogo: true))
        .edgesIgnoringSafeArea(.all)
    }
}

extension EmployeeRankingView {
    
    var EmployeeInforView: some View {
        VStack {
            URLImageView(url: employeeRankingViewModel.employeeInfor.avatar)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
                .padding(.all, 7)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.4), lineWidth: 3))
            
            VStack {
                HStack(spacing: 0) {
                    Text(employeeRankingViewModel.employeeInfor.name)
                        .bold()
                        .foregroundColor(.blue)
                    Text(" - ")
                    Text(employeeRankingViewModel.employeeInfor.userId)
                        .bold()
                }.font(.system(size: 20))
                
                Text(employeeRankingViewModel.employeeInfor.department)
                
                Spacer().frame(height: 10)
                
                HStack(spacing: 0) {
                    Text("\("ranking_of_this_month".localized): ")
                    Text("\("top".localized.uppercased()) \(employeeRankingViewModel.employeeRank.getRank()) - ")
                        .foregroundColor(.blue)
                    getPointView(point: employeeRankingViewModel.employeeRank.getTotalScore())
                        .foregroundColor(.blue)
                }
                
            }.font(.system(size: 16))
        }
    }
    
    var EmployeeListView: some View {
        VStack {
            if employeeRankingViewModel.isLoading && !employeeRankingViewModel.isRefreshing {
                LoadingPageView()
            } else {
                ForEach(employeeRankingViewModel.employeeRecognitionList.indices, id: \.self) { index in
                    VStack {
                        
                        // Print date
                        let i = self.employeeRankingViewModel.isNewDate(index: index)
                        
                        if i != -1 {
                            Text(employeeRankingViewModel.sameDateGroup[i].date)
                                .bold()
                                .font(.system(size: 14))
                                .frame(width: ScreenInfor().screenWidth * 0.9, alignment: .leading)
                                .padding(.vertical)
                        }
                        
 
                        RecognitionNewsCardView(companyData: employeeRankingViewModel.employeeRecognitionList[index], index: index, proxy: $proxy, newsFeedType: Constants.RecognitionNewsFeedType.YOUR_HISTORY, isHaveReactAndCommentButton: true)
                                .foregroundColor(.black)
                       
                        
                        Spacer().frame(height: 20)
                        
                    }
                    .scrollId(index)
                    
                }
                
                //Infinite Scroll View
                
                if (employeeRankingViewModel.fromIndex == employeeRankingViewModel.employeeRecognitionList.count && isShowProgressView) {
                    
                    ActivityIndicator(isAnimating: true)
                        .onAppear {
                            
                            // Because the maximum length of the result returned from the API is 10...
                            // So if length % 10 != 0 will be the last queue...
                            // We only send request if it have more data to load...
                            if employeeRankingViewModel.employeeRecognitionList.count % Constants.MAX_NUM_API_LOAD == 0 {
                                self.employeeRankingViewModel.reloadData()
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
                        
                        if !employeeRankingViewModel.employeeRecognitionList.isEmpty && minY < height && employeeRankingViewModel.employeeRecognitionList.count >= Constants.MAX_NUM_API_LOAD  {
                            
                            DispatchQueue.main.async {
                                employeeRankingViewModel.fromIndex = employeeRankingViewModel.employeeRecognitionList.count
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
}

struct EmployeeRankingView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeRankingView(employeeId: 0)
    }
}
