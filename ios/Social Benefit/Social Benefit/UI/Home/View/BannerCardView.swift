//
//  BannerCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

let ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

struct InternalNewsBannerView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var isMove: Bool = false
    
    var body: some View {
        VStack {
            
            TopTitleView(title: "internal_news".localized, topTitleTapped: topTitleTapped)
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            Spacer().frame(height: 15)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if internalNewsViewModel.allInternalNews.count != 0 { //If Data can read
                        PageViewController(pages: getInternalNewsData(data: internalNewsViewModel.allInternalNews, imageTapped: imageTapped), currentPage: $currentPage)
 
                        PageControl(numberOfPages: internalNewsViewModel.allInternalNews.count, currentPage: $currentPage)
                            .onReceive(ImageSlideTimer) { _ in self.currentPage = (self.currentPage + 1) % internalNewsViewModel.allInternalNews.count }
                    } else {
                        EmptyView()
                    }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            .background(
                ZStack {
                    NavigationLink(
                        destination: InternalNewsView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar).navigationBarHidden(true),
                        isActive: $isMove,
                        label: { EmptyView() })
                }
            )
        }
        .foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
    
    func topTitleTapped() {
        self.isMove = true
        homeScreenViewModel.isPresentedTabBar.toggle()
    }
    
    func imageTapped() {
        homeScreenViewModel.isPresentedTabBar = false
        homeViewModel.isPresentInternalNewDetail.toggle()

        if let index = homeViewModel.selectedIndex {
            homeViewModel.selectedInternalNew = internalNewsViewModel.allInternalNews[index]
        }
    }
}


struct RecognitionsBannerView: View {

    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var selection: Int? = nil
    @State var isAnimating: Bool = true
    @State var selectedIndex: Int = 0
    
//    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            TopTitleView(title: "recognitions_in_company".localized, topTitleTapped: topTitleTapped)

            Divider().frame(width: ScreenInfor().screenWidth * 0.9)

            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    EmptyView()
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 100)
            .background(Color.white)
            .cornerRadius(30)
        }
        .foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
    
    func topTitleTapped() {
        
    }
}


struct PromotionsBannerView: View {

    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var data: [MerchantListData] = []

    var body: some View {
        VStack {
            TopTitleView(title: "promotions".localized, topTitleTapped: toptitleTapped)

            Divider().frame(width: ScreenInfor().screenWidth * 0.9)

            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if data.count != 0 { //If Data can read
                        let pages = getPromotionData(data: data, imageTapped: imageTapped)
                        PageViewController(pages: pages, currentPage: $currentPage)
                            .onReceive(ImageSlideTimer) { _ in self.currentPage = (self.currentPage + 1) % data.count }
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
        }
        .foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
    
    func toptitleTapped() {
        homeScreenViewModel.selectedTab = "tag"
    }
    
    func imageTapped() {
        homeScreenViewModel.isPresentedTabBar = false
        homeViewModel.isPresentVoucherDetail.toggle()

        if let index = homeViewModel.selectedIndex {
            homeViewModel.selectedVoucherId = data[index].id
        }
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
    
    var title: String
    var topTitleTapped: () -> ()
    
    var body: some View {
        
        Button(action: {
            topTitleTapped()
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
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var image: String
    var index: Int
    var imageTapped: () -> ()
    
    var body: some View {
        URLImageView(url: image)
            .onTapGesture {
                DispatchQueue.main.async {
                    homeViewModel.selectedIndex = index
                    ImageSlideTimer.upstream.connect().cancel()
                    imageTapped()
                }
            }
    }
}

func getInternalNewsData(data: [InternalNewsData], imageTapped: @escaping () -> ()) -> [BannerContentView] {
    
    var result = [BannerContentView]()
    
    for i in data.indices {
        result.append(BannerContentView(image: data[i].cover, index: i, imageTapped: imageTapped))
    }
    return result
}

func getPromotionData(data: [MerchantListData], imageTapped: @escaping () -> ()) -> [BannerContentView] {

    var result = [BannerContentView]()
    
    for i in data.indices {
        result.append(BannerContentView(image: data[i].cover, index: i, imageTapped: imageTapped))
    }
    return result
}

struct BannerCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
