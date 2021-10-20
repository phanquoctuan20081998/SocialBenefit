//
//  BackgroundView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 25/08/2021.
//

import SwiftUI

struct BackgroundViewWithNotiAndSearch: View {
    @EnvironmentObject var homeScreen: HomeScreenViewModel

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
                            .frame(height: 30)
                            .padding(.leading)
                            .onTapGesture {
                                homeScreen.selectedTab = "house"
                            }
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            
                            // Bell Button
                            Button {
                                // Do something
                                
                                
                            } label: {
                                Image(systemName: "bell.fill")
                            }
                            
                            // Search Button
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
                                self.presentationMode.wrappedValue.dismiss()
                                self.isActive.toggle()
                                if !isHiddenTabBarWhenBack {
                                    homeScreen.isPresentedTabBar = true
                                }
                                
                                backButtonTapped()
                                
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
                                .frame(height: 30, alignment: .trailing)
                                .padding(.trailing, 25)
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
//        BackgroundViewWithNotiAndSearch()
        HomeScreenView(selectedTab: "tag")
        
//        MyVoucherView()
//            .environmentObject(HomeScreenViewModel())
//            .environmentObject(MyVoucherViewModel())
//            .environmentObject(InternalNewsViewModel())
////            .environmentObject(SpecialOffersViewModel())
//            .environmentObject(MerchantCategoryItemViewModel())
////            .environmentObject(OffersViewModel())
//            .environmentObject(ConfirmInforBuyViewModel())
    }
}

