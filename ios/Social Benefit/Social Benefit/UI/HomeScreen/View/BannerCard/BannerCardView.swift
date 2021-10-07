//
//  BannerCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//
import SwiftUI

struct InternalNewsBannerView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    @State var index = 0
    @State var isPresent = false
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: InternalNewsView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar).navigationBarHidden(true),
                isActive: $isPresent,
                label: {
                    TopTitleView(isPresent: $isPresent, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, title: "internal_news".localized)
                })
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            Spacer().frame(height: 15)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if internalNewsViewModel.allInternalNews.count != 0 { //If Data can read
                        PageViewController(pages: getInternalNewsData(data: internalNewsViewModel.allInternalNews), currentPage: $currentPage)
                        PageControl(numberOfPages: internalNewsViewModel.allInternalNews.count, currentPage: $currentPage)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
        }.foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
}


struct RecognitionsBannerView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    @State var index = 0
    @State var isPresent = false
    @State private var currentPage = 0
    @State var data: [InternalNewsData] = []
    
    var body: some View {
        VStack {
            TopTitleView(isPresent: $isPresent, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, title: "recognitions_in_company".localized)
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    EmptyView()
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
        }.foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
}


struct PromotionsBannerView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    @State var index = 0
    @State var isPresent = false
    @State private var currentPage = 0
    @State var data: [MerchantListData] = []
    
    var body: some View {
        VStack {
            TopTitleView(isPresent: $isPresent, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, title: "promotions".localized)
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if data.count != 0 { //If Data can read
                        let pages = getPromotionData(data: data)
                        PageViewController(pages: pages, currentPage: $currentPage)
                        PageControl(numberOfPages: data.count, currentPage: $currentPage)
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            
            //Get data from API
            .onAppear {
                MerchantListService().getAPI { (data) in
                    self.data = data
                }
            }
        }.foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
}

struct MainCardView: View {
    var body: some View {
        VStack {
            HStack {
                Image("confetti_1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50, alignment: .leading)
                
                Spacer()
                
                VStack {
                    Text("total_point".localized)
                    
                    Spacer()
                    
                    Text("2,568")
                        .foregroundColor(.blue)
                        .bold()
                        .font(.system(size: 35))
                }
                
                Spacer()
                
                Image("confetti_2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50, alignment: .trailing)
            }
            
            Spacer()
            
            HStack (spacing: 5) {
                mainButton(text: "recognize".localized, image: "ic_recognize", color: Color("light_pink"))
                mainButton(text: "my_voucher".localized, image: "ic_my_voucher", color: Color("light_yellow"))
                mainButton(text: "my_order".localized, image: "ic_my_order", color: Color("light_orange"))
                mainButton(text: "others".localized, image: "ic_others", color: Color("light_blue"))
            }
            
        }.padding()
        .frame(width: ScreenInfor().screenWidth*0.93, height: 170)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        
    }
}

struct mainButton: View {
    var text: String
    var image: String
    var color: Color
    
    var body: some View {
        VStack {
            
            Button(action: {
                // Do something
                
            }, label: {
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [color, .white]), startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 50, height: 50, alignment: .center)
                    .overlay(
                        Image(image)
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .padding(.all, 5)
                    )
            })
            
            Text(text)
                .bold()
                .font(.system(size: 12))
            
        }.frame(width: 80)
    }
}

struct TopTitleView: View {
    
    @Binding var isPresent: Bool
    @Binding var isPresentedTabBar: Bool
    var title: String
    
    var body: some View {
        
        Button(action: {
            self.isPresent.toggle()
            self.isPresentedTabBar.toggle()
        }, label: {
            HStack {
                Text(title)
                    .frame(height: 40, alignment: .trailing)
                    .font(.system(size: 13))
                    .padding(.horizontal, 10)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(BannerCurveShape())
                Spacer()
                HStack {
                    Text("see_all".localized)
                        .font(.system(size: 13))
                    Image(systemName: "chevron.right")
                }
            }.padding(.horizontal, 15)
        })
    }
}

struct BannerContentView: View {
    
    var image: String
    
    var body: some View {
        URLImageView(url: image)
            .navigationBarHidden(true)
    }
}

func getInternalNewsData(data: [InternalNewsData]) -> [BannerContentView] {
    var result = [BannerContentView]()
    
    for item in data {
        result.append(BannerContentView(image: item.cover))
    }
    return result
}

func getPromotionData(data: [MerchantListData]) -> [BannerContentView] {
    var result = [BannerContentView]()
    
    for item in data {
        result.append(BannerContentView(image: item.cover))
    }
    return result
}

struct BannerCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
