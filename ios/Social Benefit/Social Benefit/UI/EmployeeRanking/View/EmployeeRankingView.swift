//
//  EmployeeRankingView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/11/2021.
//

import SwiftUI

struct EmployeeRankingView: View {
    
    @ObservedObject var employeeRankingViewModel: EmployeeRankingViewModel
    
    init(employeeId: Int) {
        self.employeeRankingViewModel = EmployeeRankingViewModel(employeeId: employeeId)
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.13)
            EmployeeInforView
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
                    getPointString(point: employeeRankingViewModel.employeeRank.getTotalScore())
                }
                
            }.font(.system(size: 16))
        }
    }
}

struct EmployeeRankingView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeRankingView(employeeId: 0)
    }
}
