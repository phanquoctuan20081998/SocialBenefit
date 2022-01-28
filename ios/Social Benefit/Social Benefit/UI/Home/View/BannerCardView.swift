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
import MedLib

var ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

struct InternalNewsBannerView: View {
    
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var currentPage = 0
    @State var isMoveToInternalNews: Bool = false
    @State var isMoveToInternalNewsDetail: Bool = false
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
                                        
                                        //Click count
                                        countClick(contentId: internalNewsViewModel.allInternalNewsBanner[index].contentId, contentType: Constants.ViewContent.TYPE_INTERNAL_NEWS)
                                    }
                            }
                        }
                        //                        .aspectRatio(4/3, contentMode: .fit)
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
                        destination: NavigationLazyView(InternalNewsView()),
                        isActive: $isMoveToInternalNews,
                        label: { EmptyView() })
                    NavigationLink(
                        destination: NavigationLazyView(InternalNewsDetailView(internalNewData: homeViewModel.selectedInternalNew!)),
                        isActive: $isMoveToInternalNewsDetail,
                        label: { EmptyView() })
                }
            )
        }
        .foregroundColor(.black)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
    }
    
    func topTitleTapped() {
        self.isMoveToInternalNews = true
        
        // Click count
        countClick()
    }
    
    func imageTapped() {
        homeScreenViewModel.isPresentedTabBar = false
        isMoveToInternalNewsDetail = true
        
        if let index = homeViewModel.selectedIndex {
            if index < internalNewsViewModel.allInternalNews.count {
                homeViewModel.selectedInternalNew = internalNewsViewModel.allInternalNews[index]
            }
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
                                        
                                        // Click count
                                        countClick(contentId: homeViewModel.allRecognitionPost[index].getId(), contentType: Constants.ViewContent.TYPE_RECOGNITION)
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
        
        // Click count
        countClick()
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
                                        
                                        //Click count
                                        countClick(contentId: data[index].id, contentType: Constants.ViewContent.TYPE_VOUCHER)
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
        
        // Click count
        countClick()
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
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var personalPoint: Int
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
            
            VStack {
                
                TitleView
                
                HStack {
                    if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                        Spacer()
                        RecognitionButton()
                        Spacer()
                        MyVoucherButton()
                        Spacer()
                    }
                    
                    // Merchant Specials
                    if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VNP) {
                        VNPTButton()
                    }
                    
                    if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.PTI) {
                        PTIButton()
                    }
                    
                    if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VUI) {
                        VUIButton()
                    }
                    
                    if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.MED247) {
                        Med247Button()
                    }
                    
                    // Other Button
                    if isDisplayOtherButton() {
                        OtherButton
                    }
                }
            }
        }
        .frame(width: ScreenInfor().screenWidth * 0.93, height: isDoesNotHaveButton() ? 200 : 150)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
    }
}

extension MainCardView {
    
    var TitleView: some View {
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
    }
    
    var OtherButton: some View {
        Button {
            homeScreenViewModel.isPresentOtherPopUp = true
        } label: {
            mainButton(text: "other".localized, image: "ic_others", color: Color("light_blue"))
                .foregroundColor(.black)
        }
    }
    
    func isDoesNotHaveButton() -> Bool {
        if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) || isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VUI) || isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VNP) || isDisplayMerchantSpecial(Constants.MerchantSpecialCode.PTI) ||
            isDisplayMerchantSpecial(Constants.MerchantSpecialCode.MED247) {
            return true
        }
        
        return false
    }
    
    func isDisplayOtherButton() -> Bool {
        return false
    }
}

struct RecognitionButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToRecognition = false
    
    var body: some View {
        Button {
            self.moveToRecognition = true
            self.homeScreenViewModel.isPresentedTabBar = false
            countClick()
        } label: {
            mainButton(text: "recognize".localized, image: "ic_recognize", color: Color("light_pink"))
                .foregroundColor(.black)
        }
        .background(
            NavigationLink(destination: NavigationLazyView(RecognitionActionView()),
                           isActive: $moveToRecognition,
                           label: { EmptyView() })
        )
    }
}

struct MyVoucherButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToMyVoucher = false
    
    var body: some View {
        Button {
            self.moveToMyVoucher = true
            countClick()
        } label: {
            mainButton(text: "my_voucher".localized, image: "ic_my_voucher", color: Color("light_yellow"))
                .foregroundColor(.black)
        }.background(
            NavigationLink(destination: NavigationLazyView(MyVoucherView()),
                           isActive: $moveToMyVoucher,
                           label: { EmptyView() })
        )
    }
}

struct VNPTButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToVNP = false
    
    var body: some View {
        VStack {
            let VNP = userInfor.merchantSpecialData.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.VNP }) ?? MerchantSpecialList()
            
            let VNPSettings = VNP.merchantSpecialSettings
            
            let url = VNP.merchantSpecialSettings![VNPSettings?.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.URL_WEBVIEW }) ?? 0].settingValue
            
            VStack {
                Button {
                    self.moveToVNP = true
                    countClick()
                } label: {
                    mainButton(text: VNP.merchantName ?? "vnpt".localized, image: "ic_vnpt", color: Color("light_blue"))
                        .foregroundColor(.black)
                }
            }.background(
                NavigationLink(destination: NavigationLazyView(VinaphoneView(webViewURL: url ?? "", merchantName: VNP.merchantName!)),
                               isActive: $moveToVNP,
                               label: { EmptyView() })
            )
        }
    }
}

struct PTIButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToPTI = false
    
    var body: some View {
        VStack {
            let PTI = userInfor.merchantSpecialData.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.PTI }) ?? MerchantSpecialList()
            
            let PTISettings = PTI.merchantSpecialSettings
            
            let url = PTI.merchantSpecialSettings![PTISettings?.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.URL_WEBVIEW }) ?? 0].settingValue
            
            let urlWithEmployeeId = url!.replacingOccurrences(of: "{0}", with: userInfor.employeeId)
            
            VStack {
                Button {
                    self.moveToPTI = true
                    countClick()
                } label: {
                    mainButton(text: PTI.merchantName ?? "pti".localized, image: "ic_pti", color: Color("light_orange"))
                        .foregroundColor(.black)
                }
            }.background(
                NavigationLink(destination: NavigationLazyView(PTIView(webViewURL: urlWithEmployeeId, merchantName: PTI.merchantName!)),
                               isActive: $moveToPTI,
                               label: { EmptyView() })
            )
        }
    }
}

struct VUIButton: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToVUI = false
    
    var body: some View {
        VStack {
            let VUI = userInfor.merchantSpecial.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.VUI })
            VStack {
                Button {
                    self.moveToVUI = true
                    countClick()
                } label: {
                    mainButton(text: (VUI?.merchantName!)!, image: "ic_vui", color: Color.green)
                        .foregroundColor(.black)
                }
            }.background(
                NavigationLink(destination: NavigationLazyView(VUIAppView()),
                               isActive: $moveToVUI,
                               label: { EmptyView() })
            )
        }
    }
}

struct Med247Button: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State var moveToMED = false
    
    var body: some View {
        VStack {
            let MED247 = userInfor.merchantSpecialData.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.MED247 }) ?? MerchantSpecialList()
            
            VStack {
                Button {
                    moveToMED = true
                    
                    countClick()
                } label: {
                    mainButton(text: MED247.merchantName!, image: "ic_med247", color: Color("light_blue"))
                        .foregroundColor(.black)
                }
            }.background(
                NavigationLink(destination: NavigationLazyView(Med247ViewControllerRepresentation().navigationBarHidden(true)),
                               isActive: $moveToMED,
                               label: { EmptyView() })
            )
        }
    }
}

struct OthersButtonPopUpView: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        if homeScreenViewModel.isPresentOtherPopUp {
            ZStack {
                Color.black.opacity(0.5)
                    .onTapGesture {
                        homeScreenViewModel.isPresentOtherPopUp = false
                    }
                
                VStack {
                    HStack {
                        Button {
                            homeScreenViewModel.isPresentOtherPopUp = false
                        } label: {
                            Image(systemName: "arrow.backward")
                        }
                        
                        Text("others".localized)
                    }
                    .padding()
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VNP) {
                                VNPTButton()
                            }
                            
                            if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.PTI) {
                                PTIButton()
                            }
                            
                            if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.VUI) {
                                VUIButton()
                            }
                            
                            if isDisplayMerchantSpecial(Constants.MerchantSpecialCode.MED247) {
                                Med247Button()
                            }
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: ScreenInfor().screenWidth * 0.8, height: ScreenInfor().screenHeight * 0.2)
                .background(Color.white)
                .cornerRadius(30)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct mainButton: View {
    var text: String
    var image: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
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

struct OtherButtonPopUpView: ViewModifier {
    
    var popupContent: AnyView
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent)
    }
}

extension View {
    
    func othersButtonPopUp(_ popup: AnyView) -> some View {
        return modifier(OtherButtonPopUpView(popupContent: popup))
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        OthersButtonPopUpView()
            .environmentObject(HomeScreenViewModel())
    }
}
