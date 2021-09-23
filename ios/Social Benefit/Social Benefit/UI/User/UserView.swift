//
//  UserView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 17/08/2021.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                    .frame(height: 70)
                
                NavigationLink(destination: UserInformationView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar).navigationBarHidden(true),
                               tag: 1,
                               selection: $selection,
                               label: {
                                UserInforView(selection: $selection, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar)
                               })
                
                Spacer()
                    .frame(height: 30)
                
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        NavigationLink(destination: Text("2"), tag: 2, selection: $selection) {
                            FunctionCardView(thumnail: "clock.arrow.circlepath", thumailColor: Color.gray, functionName: "point_history".localized, chevron: true, selection: $selection, selectedNumber: 2)
                        }
                        
                        NavigationLink(destination: Text("3"), tag: 3, selection: $selection) {
                            FunctionCardView(thumnail: "heart.fill", thumailColor: Color.red, functionName: "favorite".localized, chevron: true, selection: $selection, selectedNumber: 3)
                        }
                        
                        NavigationLink(destination: ListOfBenefitsView().navigationBarHidden(true), tag: 4, selection: $selection) {
                            FunctionCardView(thumnail: "list.number", thumailColor: Color.blue, functionName: "benefits".localized, chevron: true, selection: $selection, selectedNumber: 4)
                        }
                        
                        NavigationLink(destination: Text("5"), tag: 5, selection: $selection) {
                            FunctionCardView(thumnail: "chart.bar.xaxis", thumailColor: Color.purple, functionName: "surveys".localized, chevron: true, selection: $selection, selectedNumber: 5)
                        }
                    }.padding(.top, 10)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack(spacing: 8) {
                        NavigationLink(destination: Text("6"), tag: 6, selection: $selection) {
                            FunctionCardView(thumnail: "gearshape.fill", thumailColor: Color.blue, functionName: "setting".localized, chevron: true, selection: $selection, selectedNumber: 6)
                        }
                        
                        NavigationLink(destination: Text("7"), tag: 7, selection: $selection) {
                            FunctionCardView(thumnail: "text.bubble.fill", thumailColor: Color.green, functionName: "customer".localized, chevron: false, selection: $selection, selectedNumber: 7)
                        }
                        
                        NavigationLink(destination: Text("8"), tag: 8, selection: $selection) {
                            FunctionCardView(thumnail: "star.fill", thumailColor: Color.yellow, functionName: "rate".localized, chevron: false, selection: $selection, selectedNumber: 8)
                        }
                    }
                    //
                    Spacer().frame(height: 30)
                    
                    VStack {
                        NavigationLink(destination: Text("9"), tag: 9, selection: $selection) {
                            FunctionCardView(thumnail: "arrow.right.doc.on.clipboard", thumailColor: Color.blue, functionName: "logout".localized, chevron: false, selection: $selection, selectedNumber: 9)
                        }
                    }
                }
                
                
            }.background(
                BackgroundViewWithNotiAndSearch()
            )
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct UserInforView: View {
    
    @Binding var selection: Int?
    @Binding var isPresentedTabBar: Bool
    
    var body: some View {
        ZStack {
            Button(action: {
                // Do something
                self.selection = 1
                self.isPresentedTabBar = false
                
            }, label: {
                HStack(spacing: 20) {
                    URLImageView(url:  userInfor.avatar)
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                        .padding(.all, 5)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    VStack(alignment: .leading) {
                        Text(userInfor.name.uppercased())
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.blue)
                            .font(Font.body.smallCaps())
                        
                        Text(userInfor.position)
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .padding(.trailing, 10)
                }
                .frame(width: ScreenInfor().screenWidth - 50, alignment: .leading)
                .padding(.leading, 30)
                .background(
                    Capsule()
                        .fill(Color.white)
                        .padding(.leading, 83)
                        .frame(width: 500, height: 80, alignment: .center)
                        .shadow(color: .black.opacity(0.15), radius: 10, x: -3, y: 3)
                )
            })
        }
    }
}



struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

