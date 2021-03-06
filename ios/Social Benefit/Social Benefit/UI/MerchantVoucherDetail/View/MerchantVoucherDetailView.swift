//
//  VoucherDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import SwiftUI

struct MerchantVoucherDetailView: View {
    
    @ObservedObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @ObservedObject var confirmInforBuyViewModel = ConfirmInforBuyViewModel()
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    
    // For navigation from homescreen
    @EnvironmentObject var homeViewModel: HomeViewModel
    var isNavigationFromHomeScreen: Bool = false
    
    var voucherId: Int
    
    @State var offset: CGFloat = 0
    @State var isActive: Bool = false
    
    init(voucherId: Int) {
        merchantVoucherDetailViewModel = MerchantVoucherDetailViewModel(voucherId: voucherId)
        self.voucherId = voucherId
    }
    
    init(isNavigationFromHomeScreen: Bool, voucherId: Int) {
        merchantVoucherDetailViewModel = MerchantVoucherDetailViewModel(voucherId: voucherId)
        self.isNavigationFromHomeScreen = isNavigationFromHomeScreen
        self.voucherId = voucherId
    }
    
    var body: some View {
        VStack {
            if merchantVoucherDetailViewModel.isLoading {
                VStack {
                    ActivityRep()
                        .frame(height: ScreenInfor().screenHeight * 0.3)
                    
                    Spacer()
                        .background(Color.white.frame(width: ScreenInfor().screenWidth))
                }
                
                .frame(width: ScreenInfor().screenWidth)
                
            } else {
                VoucherHeadline
                InformationBar()
                
                Rectangle().fill(Color.gray).frame(width: ScreenInfor().screenWidth * 0.9, height: 1)
                
                ScrollableTabView
                BottomButtonView().padding(.bottom)
            }
            
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
            
            Spacer().frame(height: 10)
            
        }.environmentObject(merchantVoucherDetailViewModel)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .overlay(
            MyVoucherButtonView()
                .padding(.init(top: ScreenInfor().screenHeight * 0.05 + 10, leading: 0, bottom: 0, trailing: 20))
            ,alignment: .topTrailing)
        .edgesIgnoringSafeArea(.all)
        
        // PopUp overlay...
        .overlay(BuyVoucherPopUp(isPresentPopUp: $confirmInforBuyViewModel.isPresentedPopup, isReloadSpecialVoucher: .constant(true), isReloadAllVoucher: .constant(true)))
        .overlay(VoucherQRPopUpView(isPresentedPopup: $merchantVoucherDetailViewModel.isShowQRPopUp, voucher: merchantVoucherDetailViewModel.QRData))
        .overlay(SuccessedMessageView(successedMessage: "copied_to_clipboard".localized, isPresented: $merchantVoucherDetailViewModel.isShowCopiedPopUp))
        .overlay(ErrorMessageView(error: confirmInforBuyViewModel.buyVoucherResponse.errorCode, isPresentedError: $confirmInforBuyViewModel.isPresentedError))
        
        
        .background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "", isHaveLogo: false, backButtonTapped: backButtonTapped))
        .onAppear {
            self.confirmInforBuyViewModel.loadData(voucherId: voucherId)
            self.homeScreenViewModel.isPresentedTabBar = false
        }
        .environmentObject(confirmInforBuyViewModel)
    }
    
    func backButtonTapped() {
        if isNavigationFromHomeScreen {
            homeViewModel.isPresentVoucherDetail = false
            homeScreenViewModel.isPresentedTabBar = true
            ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        }
    }
}

extension MerchantVoucherDetailView {
    
    var VoucherHeadline: some View {
        
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail

        return VStack {
            
            Spacer()
                .frame(height: ScreenInfor().screenHeight * 0.13)
            
            URLImageView(url: voucherDetail.imageURL)
                .scaledToFit()
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 150)
                .padding(.bottom, 20)
            
            HStack(spacing: 10) {
                Button {
                    self.merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThisMerchant.toggle()
                    self.merchantVoucherDetailViewModel.likeMerchantButtonClick()
                } label: {
                    Image(systemName: "bookmark\(self.merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThisMerchant ? ".fill" : "")")
                        .foregroundColor(self.merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThisMerchant ? .orange : .gray)
                }
                
                Text("[\(voucherDetail.merchantName)] \(voucherDetail.name)")
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding()
            
        }
        
    }
    
    var ScrollableTabView: some View {
        VStack {
            ScrollableTabBarView(offset: $offset)
            
            GeometryReader { proxy in
                ScrollableTabBar(tabs: Constants.VOUCHER_DETAIL_TAB, rect: proxy.frame(in: .global), offset: $offset) {
                    HStack(spacing: 0 ){
                        InformationTabView()
                        AppliedStoreView()
                        SimiliarVoucherView()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct InformationBar: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Button(action: {
                    
                    DispatchQueue.main.async {
                        merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThis.toggle()
                        
                        if merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThis {
                            merchantVoucherDetailViewModel.merchantVoucherDetail.favoriteValue += 1
                        } else {
                            merchantVoucherDetailViewModel.merchantVoucherDetail.favoriteValue -= 1
                        }
                    }
            
                    AddReactService().getAPI(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ReactContentType.VOUCHER, reactType: Constants.ReactType.LOVE)
                    
                    // Click count
                    countClick(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                    
                }, label: {
                    Image(systemName: "heart\(merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThis ? ".fill" : "")")
                        .foregroundColor(.red)
                })
                Text(String(merchantVoucherDetailViewModel.merchantVoucherDetail.favoriteValue))
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                Text(merchantVoucherDetailViewModel.merchantVoucherDetail.outOfDate)
            }
            
            Spacer()
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            HStack(spacing: 5) {
                Image("ic_coin")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text(getPointString(point: Int(merchantVoucherDetailViewModel.merchantVoucherDetail.pointValue)))
            }
        }.font(.system(size: 13))
        .frame(width: ScreenInfor().screenWidth * 0.9)
    }
    
    func getIndex(_ id: Int) -> [Int] {
        var index: [Int] = []
        let i1 = specialOffersViewModel.allSpecialOffers.firstIndex(where: { $0.id == id })
        let i2 = offersViewModel.allOffers.firstIndex(where: { $0.id == id })
        
        index.append(i1 ?? -1)
        index.append(i2 ?? -1)
        
        return index
        
    }
}

struct ScrollableTabBarView: View {
    
    @Binding var offset: CGFloat
    @State var width: CGFloat = 0
    
    var body: some View {
        
        let equalWidth = (ScreenInfor().screenWidth * 0.9) / CGFloat(Constants.VOUCHER_DETAIL_TAB.count)
        
        DispatchQueue.main.async {
            self.width = equalWidth
        }
        
        return ZStack(alignment: .bottomLeading) {
            Capsule()
                .fill(Color.gray)
                .frame(width: equalWidth - 15, height: 1)
                .offset(x: getOffset() + 7, y: 4)
            
            HStack(spacing: 0) {
                ForEach(Constants.VOUCHER_DETAIL_TAB.indices, id: \.self) { index in
                    Text(Constants.VOUCHER_DETAIL_TAB[index].localized)
                        .font(.system(size: 13))
                        .frame(width: equalWidth, height: 40)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                offset = ScreenInfor().screenWidth * CGFloat(index)
                            }
                        }
                }
            }.frame(width: ScreenInfor().screenWidth * 0.9)
        }
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / ScreenInfor().screenWidth
        return progress * width
    }
}



struct VoucherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantVoucherDetailView(voucherId: 0)
            .environmentObject(MerchantVoucherDetailViewModel(voucherId: 0))
            .environmentObject(HomeScreenViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
        
//        HomeScreenView(selectedTab: "tag")
    }
}
