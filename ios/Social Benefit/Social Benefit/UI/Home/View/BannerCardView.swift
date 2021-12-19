//
//  BannerCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import ScrollViewProxy

var ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

struct InternalNewsBannerView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var isMove: Bool = false
    @State var data: [InternalNewsData] = []
    
    var body: some View {
        VStack {
            
            TopTitleView(title: "internal_news".localized, topTitleTapped: topTitleTapped)
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            Spacer().frame(height: 15)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    
                    if internalNewsViewModel.allInternalNewsBanner.count != 0 {
                        
                        PagingView(index: $currentPage.animation(), maxIndex: internalNewsViewModel.allInternalNewsBanner.count - 1) {
                            ForEach(internalNewsViewModel.allInternalNewsBanner.indices, id: \.self) { index in
                                URLImageView(url: internalNewsViewModel.allInternalNewsBanner[index].cover)
                                    .scaledToFit()
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            homeViewModel.selectedIndex = index
                                            ImageSlideTimer.upstream.connect().cancel()
                                            imageTapped()
                                        }
                                    }
                            }
                        }
                        .aspectRatio(4/3, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    } else { EmptyView() }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            .background(
                ZStack {
                    NavigationLink(
                        destination: InternalNewsView().navigationBarHidden(true),
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
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var selection: Int? = nil
    @State var isAnimating: Bool = true
    @State var selectedIndex: Int = 0
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    var body: some View {
        VStack {
            
            TopTitleView(title: "recognitions_in_company".localized, topTitleTapped: topTitleTapped)
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            VStack(spacing: 15) {
                ZStack(alignment: .bottom) {
                    if homeViewModel.allRecognitionPost.count != 0 {
                        PagingView(index: $currentPage.animation(), maxIndex: homeViewModel.allRecognitionPost.count - 1) {
                            ForEach(homeViewModel.allRecognitionPost.indices, id: \.self) { index in
                                RecognitionNewsCardView(companyData: homeViewModel.allRecognitionPost[index], index: index, proxy: $proxy, newsFeedType: 0, isHaveReactAndCommentButton: false)
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            homeScreenViewModel.selectedTab = "star"
                                        }
                                    }
                            }
                        }
                    } else { EmptyView() }
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 140)
            .background(homeViewModel.allRecognitionPost.count != 0 ? Color("nissho_light_blue") : Color.white)
            .cornerRadius(30)
        }
        .foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
    
    func topTitleTapped() {
        DispatchQueue.main.async {
            homeScreenViewModel.selectedTab = "star"
        }
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
                    //                    if data.count != 0 { //If Data can read
                    //                        let pages = getPromotionData(data: data, imageTapped: imageTapped)
                    //                        PageViewController(pages: pages, currentPage: $currentPage)
                    //                        //                            .onReceive(ImageSlideTimer) { _ in self.currentPage = (self.currentPage + 1) % data.count }
                    //                        PageControl(numberOfPages: data.count, currentPage: $currentPage)
                    //                    } else {
                    //                        EmptyView()
                    //                    }
                    
                    
                    if data.count != 0 {
                        
                        PagingView(index: $currentPage.animation(), maxIndex: data.count - 1) {
                            ForEach(data.indices, id: \.self) { index in
                                URLImageView(url: data[index].cover)
                                    .scaledToFit()
                                    .onTapGesture {
                                        DispatchQueue.main.async {
                                            homeViewModel.selectedIndex = index
                                            ImageSlideTimer.upstream.connect().cancel()
                                            imageTapped()
                                        }
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    } else { EmptyView() }
                    
                    
                }
            }
            .frame(width: ScreenInfor().screenWidth * 0.92, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            
            //Get data from API
            .onAppear {
                MerchantListService().getAPI { (data) in
                    if data.count < 6 {
                        self.data = data
                    } else {
                        self.data = Array(data[0..<5])
                    }
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

//struct MainCardView: View {
//
//    @State var moveToWebView = false
//
//    @State var isRecognitonClick = false
//    @State var isMyVoucherClick = false
//
//    var body: some View {
//        VStack {
//            HStack {
//                Spacer()
//
//                VStack {
//                    Text("total_point".localized)
//
//                    Spacer()
//
//                    Text("2,568")
//                        .foregroundColor(.blue)
//                        .bold()
//                        .font(.system(size: 35))
//                }
//
//                Spacer()
//            }.background(Image("bum")
//                            .resizable()
//                            .scaledToFill())
//
//            Spacer()
//
//            HStack {
//
//                Spacer()
//
//                if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
//
//                    // Reconigion Button
//                    NavigationLink {
//                        RecognitionActionView().navigationBarHidden(true)
//                    } label: {
//                        mainButton(text: "recognize".localized, image: "ic_recognize", color: Color("light_pink"))
//                            .foregroundColor(.black)
//                    }
//
//                    Spacer()
//
//                    mainButton(text: "my_voucher".localized, image: "ic_my_voucher", color: Color("light_yellow"))
//
//                    Spacer()
//                }
//                //                mainButton(text: "my_order".localized, image: "ic_my_order", color: Color("light_orange"), buttonTapped: myOrderButtonTapped)
//
//
//
//                mainButton(text: "VNPT".localized, image: "ic_vnpt", color: Color("nissho_blue"))
//
//                Spacer()
//
//                mainButton(text: "others".localized, image: "ic_others", color: Color("light_blue"))
//
//                Spacer()
//            }.padding(.horizontal, 30)
//
//        }.padding()
//            .frame(width: ScreenInfor().screenWidth*0.93, height: 170)
//            .background(Color.white)
//            .cornerRadius(30)
//            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
//    }
//
//    func recognizeButtonTapped() {
//        self.isRecognitonClick = true
//    }
//
//    func myVoucherButtonTapped() {
//
//    }
//
//    func myOrderButtonTapped() {
//
//    }
//
//    func VNPTButtonTapped() {
//        self.moveToWebView.toggle()
//    }
//
//    func otherButtonTapped() {
//
//    }
//}

struct MainCardView: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToRecognition = false
    @State var moveToMyVoucher = false
    
    var personalPoint: Int
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("hello".localized)
                            .font(.system(size: 15))
                        Text(userInfor.name)
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        
                        if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                            HStack {
                                Text("\(self.personalPoint)")
                                    .bold()
                                    .foregroundColor(.orange)
                                    .font(.system(size: 20))
                                Image("ic_coin")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }.onTapGesture {
                                withAnimation {
                                    homeScreenViewModel.selectedTab = "star"
                                }
                                countClick()
                            }
                        }
                    }.padding(.leading, 30)
                    
                    Spacer()
                    
                    URLImageView(url: userInfor.avatar)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2))
                        .padding(.trailing, 40)
                    
                }
                
                HStack {
                    if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                        
                        Spacer()
                        
                        // Reconigion Button
                        Button {
                            self.moveToRecognition = true
                            countClick()
                        } label: {
                            mainButton(text: "recognize".localized, image: "ic_recognize", color: Color("light_pink"))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        // Reconigion Button
                        Button {
                            self.moveToRecognition = true
                            countClick()
                        } label: {
                            mainButton(text: "my_voucher".localized, image: "ic_my_voucher", color: Color("light_yellow"))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                }
                .background (
                    ZStack {
                        NavigationLink(destination: RecognitionActionView().navigationBarHidden(true), isActive: $moveToRecognition, label: { EmptyView() })
                        NavigationLink(destination: MyVoucherView().navigationBarHidden(true), isActive: $moveToMyVoucher, label: { EmptyView() })
                    }
                )
            }
        }
        .frame(width: ScreenInfor().screenWidth * 0.93, height: isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) ? 200 : 150)
        
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
            
            Text(text)
                .bold()
                .font(.system(size: 12))
        }.frame(width: 80)
    }
}

struct TopTitleView: View {
    
    var title: String
    var topTitleTapped: () -> ()
    var isSeeAll: Bool = true
    
    var body: some View {
        
        Button(action: {
            topTitleTapped()
        }, label: {
            HStack {
                Text(title)
                    .bold()
                    .frame(height: 40, alignment: .trailing)
                    .font(.system(size: 13))
                    .padding(.trailing, 20)
                    .padding(.leading, 10)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(BannerCurveShape())
                
                Spacer()
                
                if isSeeAll {
                    HStack {
                        Text("see_all".localized)
                            .font(.system(size: 13))
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.horizontal, 20)
            .foregroundColor(.blue)
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
        //        HomeScreenView(selectedTab: "house")
        //        MainCardView(personalPoint: 100)
        RecognitionsBannerView()
    }
}
