//
//  VoucherDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import SwiftUI

struct MerchantVoucherDetailView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    var voucherId: Int
    
    @State var offset: CGFloat = 0
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            VoucherHeadline
            InformationBar()
            Rectangle().fill(Color.gray).frame(width: ScreenInfor().screenWidth * 0.9, height: 1)
            ScrollableTabView
            BottomButtonView()
        }.environmentObject(merchantVoucherDetailViewModel)
        .navigationBarHidden(true)
        .overlay(
            MyVoucherButtonView()
                .padding(.trailing)
                ,alignment: .topTrailing)
        
        .overlay(BuyVoucherPopUp())
        .overlay(VoucherQRPopUpView(isPresentedPopup: $merchantVoucherDetailViewModel.isShowQRPopUp, voucher: merchantVoucherDetailViewModel.QRData))
        
        .background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "", isHaveLogo: false))
        .onAppear {
            self.merchantVoucherDetailViewModel.getData(voucherId: voucherId)
            self.confirmInforBuyViewModel.loadData(voucherId: voucherId)
            self.homeScreenViewModel.isPresentedTabBar = false 
        }
    }
}

extension MerchantVoucherDetailView {
    
    var VoucherHeadline: some View {
        
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail
        
        // Load data to display 3 bottom button
        self.merchantVoucherDetailViewModel.loadButtonController(buyVoucherInfor: confirmInforBuyViewModel.buyVoucher)
        
        return VStack {
            
            Spacer().frame(height: 50)
            
            URLImageView(url: voucherDetail.imageURL)
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 150)
                .padding(.bottom, 20)
            
            Text("[\(voucherDetail.merchantName)] \(voucherDetail.name)")
                .bold()
                .font(.system(size: 15))
                .frame(width: ScreenInfor().screenWidth * 0.9, alignment: .leading)
        }
        
    }
    
    var ScrollableTabView: some View {
        VStack {
            ScrollableTabBarView(offset: $offset)
            
            GeometryReader { proxy in
                ScrollableTabBar(tabs: Constants.VOUCHER_DETAIL_TAB, rect: proxy.frame(in: .global), offset: $offset) {
                    HStack(spacing: 0 ){
                        AppliedStoreView()
                        AppliedStoreView()
                        SimiliarVoucherView()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
    var InformationTabView: some View {
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail
        
        return ZStack(alignment: .topLeading) {
            HTMLText(html: voucherDetail.content)
                .font(.system(size: 20))
                .padding(30)
        }.frame(width: ScreenInfor().screenWidth * 0.9)
    }
}

struct InformationBar: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Button(action: {
                    
                    merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThis.toggle()
                    
                    AddReactService().getAPI(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ReactContentType.VOUCHER, reactType: Constants.ReactType.LOVE)
                    
                    if merchantVoucherDetailViewModel.merchantVoucherDetail.employeeLikeThis {
                        merchantVoucherDetailViewModel.merchantVoucherDetail.favoriteValue += 1
                    } else {
                        merchantVoucherDetailViewModel.merchantVoucherDetail.favoriteValue -= 1
                    }
                    
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
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(.yellow)
                Text("\(merchantVoucherDetailViewModel.merchantVoucherDetail.pointValue)")
            }
        }.font(.system(size: 13))
        .frame(width: ScreenInfor().screenWidth * 0.9)
    }
}

struct AppliedStoreView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        
        VStack {
            ScrollView {
                Spacer().frame(height: 20)
                VStack(spacing: 10) {
                    ForEach(merchantVoucherDetailViewModel.appliedStoreMerchantList.indices, id: \.self) { i in
                        AppliedStoreMerchantCardView(appliedStore: merchantVoucherDetailViewModel.appliedStoreMerchantList[i], index: i)
                            .padding(.horizontal)
                    }
                    
                    //Infinite Scroll View
                    
                    if (self.merchantVoucherDetailViewModel.fromIndexAppliedStore == self.merchantVoucherDetailViewModel.appliedStoreMerchantList.count && self.isShowProgressView) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                if self.merchantVoucherDetailViewModel.appliedStoreMerchantList.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.merchantVoucherDetailViewModel.reloadAppliedStore()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressView = false
                                }
                                
                            }
                        
                    } else {
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            let height = ScreenInfor().screenHeight / 1.15
                            if !self.merchantVoucherDetailViewModel.appliedStoreMerchantList.isEmpty && minY < height && self.merchantVoucherDetailViewModel.appliedStoreMerchantList.count >= Constants.MAX_NUM_API_LOAD {
                                
                                DispatchQueue.main.async {
                                    self.self.merchantVoucherDetailViewModel.fromIndexAppliedStore = self.merchantVoucherDetailViewModel.appliedStoreMerchantList.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                    
                    Spacer().frame(height: 20)
                    
                }
                Spacer().frame(height: 20)
            }
        }
        .frame(width: ScreenInfor().screenWidth)
    }
}

struct SimiliarVoucherView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer().frame(height: 20)
                VStack(spacing: 10) {
                    ForEach(merchantVoucherDetailViewModel.similarVouchers.indices, id: \.self) { i in
                        AllOfferCardView(voucherData: merchantVoucherDetailViewModel.similarVouchers[i])
                            .padding(.horizontal)
                    }
                    
                    //Infinite Scroll View
                    
                    if (self.merchantVoucherDetailViewModel.fromIndexSimilarVoucher == self.merchantVoucherDetailViewModel.similarVouchers.count && self.isShowProgressView) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                if self.merchantVoucherDetailViewModel.similarVouchers.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.merchantVoucherDetailViewModel.reloadSimilarVoucher()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressView = false
                                }
                                
                            }
                        
                    } else {
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            let height = ScreenInfor().screenHeight / 1.3
                            
                            if !self.merchantVoucherDetailViewModel.similarVouchers.isEmpty && minY < height && self.merchantVoucherDetailViewModel.similarVouchers.count >= Constants.MAX_NUM_API_LOAD {
                                
                                DispatchQueue.main.async {
                                    self.self.merchantVoucherDetailViewModel.fromIndexSimilarVoucher = self.merchantVoucherDetailViewModel.similarVouchers.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                    
                    Spacer().frame(height: 40)
                }
                Spacer().frame(height: 20)
            }
        }
        .frame(width: ScreenInfor().screenWidth)
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
                    Text(Constants.VOUCHER_DETAIL_TAB[index])
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
            .environmentObject(MerchantVoucherDetailViewModel())
            .environmentObject(HomeScreenViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
    }
}
