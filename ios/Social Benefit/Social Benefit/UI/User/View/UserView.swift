//
//  UserView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 17/08/2021.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var homescreen: HomeScreenViewModel
    @EnvironmentObject var customerSupportViewModel: CustomerSupportViewModel
    
    @ObservedObject var userViewModel = UserViewModel()
    
    @State var selection: Int? = nil
    
    // Navigation Controll
    
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
            
            NavigationLink(destination: NavigationLazyView(UserInformationView()),
                           tag: 1,
                           selection: $selection,
                           label: { UserInforView(selection: $selection) })
            
            Spacer()
                .frame(height: 20)
            
            ScrollView (.vertical, showsIndicators: false) {
                VStack(spacing: 8) {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    
                    if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                        NavigationLink(destination: NavigationLazyView(UsedPointHistoryView()), tag: 2, selection: $selection) {
                            FunctionCardView(thumnail: "clock.arrow.circlepath", thumailColor: Color.gray, functionName: "point_history".localized, chevron: true, isPresentTabBar: false, selection: $selection, selectedNumber: 2)
                        }
                    }
                    
                    if isDisplayFunction(Constants.FuctionId.BENEFIT) {
                        NavigationLink(destination: NavigationLazyView(ListOfBenefitsView()), tag: 4, selection: $selection) {
                            FunctionCardView(thumnail: "list.number", thumailColor: Color.blue, functionName: "benefits".localized, chevron: true, isPresentTabBar: false, selection: $selection, selectedNumber: 4)
                        }
                    }
                    
                    
                    if isDisplayFunction(Constants.FuctionId.SURVEY) {
                        NavigationLink(destination: NavigationLazyView(ListSurveyView()), tag: 5, selection: $selection) {
                            FunctionCardView(thumnail: "chart.bar.xaxis", thumailColor: Color.purple, functionName: "surveys".localized, chevron: true, isPresentTabBar: false, selection: $selection, selectedNumber: 5)
                        }
                    }
                }.padding(.top, 10)
                
                Spacer()
                    .frame(height: 30)
                
                VStack(spacing: 8) {
                    NavigationLink(destination: NavigationLazyView(SettingsView()), tag: 6, selection: $selection) {
                        FunctionCardView(thumnail: "gearshape.fill", thumailColor: Color.blue, functionName: "setting".localized, chevron: true, isPresentTabBar: false, selection: $selection, selectedNumber: 6)
                    }
                    
                    
                    FunctionCardView(thumnail: "text.bubble.fill", thumailColor: Color.green, functionName: "customer".localized, chevron: false, isPresentTabBar: true, selection: $selection, selectedNumber: 7, isCountClick: false)
                    
                }
                
                Spacer().frame(height: 30)
                
                VStack {
                    Button {
                        Utils.setLoginIsRoot()
                    } label: {
                        
                        HStack {
                            Image(systemName: "arrow.right.doc.on.clipboard")
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding(.leading, 10)
                                .foregroundColor(Color.blue)
                            
                            Text("logout".localized)
                                .foregroundColor(.black)
                            Spacer()
                            
                        }
                        .frame(width: ScreenInfor().screenWidth - 22*2, height: 50, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
                        
                    }
                }
                .background(
                    NavigationLink(destination: NavigationLazyView(LoginView()), tag: 9, selection: $selection) { EmptyView() }
                )
                
                Spacer()
                    .frame(height: 100)
            }
        }
        .background(BackgroundViewWithNotiAndSearch())
        
        .onAppear {
            homescreen.isPresentedTabBar = true
        }
    }
}

struct UserInforView: View {
    
    @Binding var selection: Int?
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        
        Button(action: {
            // Do something
            self.selection = 1
            self.homeScreenViewModel.isPresentedTabBar = false
            
            // Click count
            countClick()
            
        }, label: {
            HStack {
                HStack(spacing: 15) {
                    
                    URLImageView(url: userInfor.avatar)
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                        .padding(.all, 5)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text(userInfor.name.uppercased())
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                            .font(Font.body.smallCaps())
                        
                        Text(userInfor.position)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                    }.frame(maxWidth: ScreenInfor().screenWidth * 0.6, alignment: .leading)
                    
                    Spacer()
            
                }.frame(width: ScreenInfor().screenWidth * 0.9)
                Spacer()
            }
            .overlay(
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .padding(.trailing, ScreenInfor().screenWidth * 0.1)
                , alignment: .trailing
            )
            .background(
                Capsule()
                    .fill(Color.white)
                    .frame(width: ScreenInfor().screenWidth * 2, height: 80, alignment: .leading)
                    .shadow(color: .black.opacity(0.15), radius: 10, x: -3, y: 3),
                alignment: .leading
            )
            
            .padding(.leading, 20)
        })
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(HomeScreenViewModel())
    }
}





