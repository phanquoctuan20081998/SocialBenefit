//
//  BackgroundView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 25/08/2021.
//

import SwiftUI

struct BackgroundViewWithNotiAndSearch: View {
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    @State var total: Int = 0
    
    var body: some View {
        VStack {
            
            Image("pic_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea([.top])
                .frame(width: ScreenInfor().screenWidth)
                .overlay(
                    HStack {
                        URLImageView(url: userInfor.companyLogo)
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(.leading)
                            .onTapGesture {
                                homeScreen.selectedTab = "house"
                            }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            
                            NavigationLink {
                                NavigationLazyView(NotificationView())
                            } label: {
                                Image(systemName: "bell.fill")
                                    .overlay(
                                        ZStack {
                                            if total != 0 {
                                                Circle()
                                                    .fill(Color.orange)
                                                    .frame(width: 15, height: 15)
                                                
                                                Text("\(total)")
                                                    .bold()
                                                    .font(.system(size: 8))
                                                    .foregroundColor(.white)
                                            }
                                        }.offset(x: 10, y: -8)
                                    )
                            }
                            
                            Button {
                                withAnimation(.easeInOut) {
                                    homeScreen.isPresentedSearchView = true
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                            }
                        }
                        .foregroundColor(.blue)
                        .padding(.trailing)
                        
                    }
                        .padding(.top, ScreenInfor().screenHeight * 0.05)
                    , alignment: .top)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    NotificationCountService().getAPI { data in
                        self.total = data
                    }
                }
            Spacer()
        }
    }
}

struct BackgroundViewWithoutNotiAndSearch: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    
    @Binding var isActive: Bool
    
    var title: String
    var isHaveLogo: Bool
    var isHiddenTabBarWhenBack = true
    
    var backButtonTapped: () -> () = { }
    
    var isHaveDiffirentHandle: Bool = false
    var diffirentHandle: () -> () = { }
    
    var body: some View {
        VStack {
            Image("pic_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea([.top])
                .frame(width: ScreenInfor().screenWidth)
                .overlay(
                    HStack {
                        HStack {
                            Button(action: {
                                if !isHaveDiffirentHandle {
                                    self.presentationMode.wrappedValue.dismiss()
                                    self.isActive.toggle()
                                    
                                    backButtonTapped()
                                } else {
                                    diffirentHandle()
                                }
                                
                                if !isHiddenTabBarWhenBack {
                                    homeScreen.isPresentedTabBar = true
                                }
                                
                            }, label: {
                                VStack(alignment: .leading) {
                                    Image(systemName: "arrow.backward")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .padding(.leading)
                                }
                            }).padding()
                            
                            if !title.isEmpty {
                                Text(title)
                                    .bold()
                                    .foregroundColor(.blue)
                                    .font(.system(size: 15))
                            }
                            
                            Spacer()
                        }
                        
                        if isHaveLogo {
                            URLImageView(url: userInfor.companyLogo)
                                .scaledToFit()
                                .frame(height: 30, alignment: .trailing)
                                .padding(.trailing, 25)
                                .onTapGesture {
                                    Utils.setTabbarIsRoot()
                                }
                        }
                    }.padding(.top, ScreenInfor().screenHeight * 0.05)
                    ,alignment: .top)
                .edgesIgnoringSafeArea(.all)
            
            Spacer()
        }
    }
}


struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "tag")
    }
}

