//
//  FavoriteMerchantDetailView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 15/02/2022.
//

import SwiftUI

struct FavoriteMerchantDetailView: View {
    @ObservedObject var favoriteMerchantSpecialOfferViewModel: FavoriteMerchantSpecialOfferViewModel
    @ObservedObject var favoriteMerchantOfferViewModel: FavoriteMerchantOfferViewModel
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    @State var isMoveToMerchantDetailSpecialOffer = false
    @State var selectedVoucherIdSpecialOffer = 0
    @State var isShowProgressViewSpecialOffer = false
    
    @State var isMoveToMerchantDetailOffer = false
    @State var selectedVoucherIdOffer = 0
    @State var isShowProgressViewOffer = false
    
    init(merchantId: Int) {
        favoriteMerchantSpecialOfferViewModel = FavoriteMerchantSpecialOfferViewModel(merchantId: merchantId)
        favoriteMerchantOfferViewModel = FavoriteMerchantOfferViewModel(merchantId: merchantId)
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: ScreenInfor().screenHeight * 0.13)
            specialOffers
            merchantOffers
        }
        .overlay(MyVoucherButtonView()
                    .padding(.init(top: ScreenInfor().screenHeight * 0.05 + 10, leading: 0, bottom: 0, trailing: 20))
                 , alignment: .topTrailing)
        .edgesIgnoringSafeArea(.all)
        .overlay(ErrorMessageView(error: confirmInforBuyViewModel.buyVoucherResponse.errorCode, isPresentedError: $confirmInforBuyViewModel.isPresentedError))
        .overlay(BuyVoucherPopUp(isPresentPopUp: $confirmInforBuyViewModel.isPresentedPopup))
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(false), title: "your_favorite_merchant".localized.uppercased(), isHaveLogo: false))
        .background(
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(MerchantVoucherDetailView(voucherId: self.selectedVoucherIdSpecialOffer)),
                    isActive: $isMoveToMerchantDetailSpecialOffer,
                    label: {
                        EmptyView()
                    })
                NavigationLink(destination: EmptyView(), label: {})
                
                NavigationLink(
                    destination: NavigationLazyView(MerchantVoucherDetailView(voucherId: self.selectedVoucherIdOffer)),
                    isActive: $isMoveToMerchantDetailOffer,
                    label: {
                        EmptyView()
                    })
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
        .navigationBarHidden(true)
    }
}

extension FavoriteMerchantDetailView {
    var specialOffers: some View {
        VStack(alignment: .leading) {
            Text("special_offer".localized.uppercased())
                .font(.system(size: 18, weight: .heavy, design: .default))
                .padding(.leading)
                .foregroundColor(.orange)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers.indices, id: \.self) { i in
                        Button {
                            self.isMoveToMerchantDetailSpecialOffer = true
                            self.selectedVoucherIdSpecialOffer = favoriteMerchantSpecialOfferViewModel.allSpecialOffers[i].id
                            
                            // Click count
                            countClick(contentId: self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers[i].id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                        } label: {
                            SpecialOfferCardView(voucherData: self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers[i], choosedIndex: i)
                                .foregroundColor(.black)
                        }.buttonStyle(NavigationLinkNoAffectButtonStyle())
                    }
                    
                    //Infinite Scroll View
                    
                    if (self.favoriteMerchantSpecialOfferViewModel.fromIndex == self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers.count && self.isShowProgressViewSpecialOffer) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                
                                // Because the maximum length of the result returned from the API is 10...
                                // So if length % 10 != 0 will be the last queue...
                                // We only send request if it have more data to load...
                                if self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.favoriteMerchantSpecialOfferViewModel.reLoadData()
                                }
                                
                                // Otherwise just delete the ProgressView after 1 seconds...
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressViewSpecialOffer = false
                                }
                                
                            }
                        
                    } else {
                        GeometryReader { reader -> Color in
                            let minX = reader.frame(in: .global).maxX
                            let width = ScreenInfor().screenWidth / 1.3
                            
                            if !self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers.isEmpty && minX < width && favoriteMerchantSpecialOfferViewModel.allSpecialOffers.count >= Constants.MAX_NUM_API_LOAD {
                                
                                DispatchQueue.main.async {
                                    self.favoriteMerchantSpecialOfferViewModel.fromIndex = self.favoriteMerchantSpecialOfferViewModel.allSpecialOffers.count
                                    self.isShowProgressViewSpecialOffer = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                }.padding()
            }
        }
    }
    
    var merchantOffers: some View {
        VStack(alignment: .leading) {
            Text("special".localized.uppercased())
                .font(.system(size: 18, weight: .heavy, design: .default))
                .padding(.leading)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 2) {
                    VStack(spacing: 15) {
                        ForEach(self.favoriteMerchantOfferViewModel.allOffers.indices, id: \.self) { i in
                            Button {
                                self.isMoveToMerchantDetailOffer = true
                                self.selectedVoucherIdOffer = favoriteMerchantOfferViewModel.allOffers[i].id
                                
                                // Click count
                                countClick(contentId: favoriteMerchantOfferViewModel.allOffers[i].id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                            } label: {
                                AllOfferCardView(voucherData: self.favoriteMerchantOfferViewModel.allOffers[i])
                                    .foregroundColor(.black)
                            }.buttonStyle(NavigationLinkNoAffectButtonStyle())
                            NavigationLink(destination: EmptyView(), label: {})
                        }
                        
                        //Infinite Scroll View
                        
                        if (self.favoriteMerchantOfferViewModel.fromIndex == self.favoriteMerchantOfferViewModel.allOffers.count && self.isShowProgressViewOffer) {
                            
                            ActivityIndicator(isAnimating: true)
                                .onAppear {
                                    if self.favoriteMerchantOfferViewModel.allOffers.count % Constants.MAX_NUM_API_LOAD == 0 {
                                        self.favoriteMerchantOfferViewModel.reLoadData()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowProgressViewOffer = false
                                    }
                                    
                                }
                            
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = ScreenInfor().screenHeight / 1.3
                                
                                if !self.favoriteMerchantOfferViewModel.allOffers.isEmpty && minY < height && favoriteMerchantOfferViewModel.allOffers.count >= Constants.MAX_NUM_API_LOAD {
                                    
                                    DispatchQueue.main.async {
                                        self.favoriteMerchantOfferViewModel.fromIndex = self.favoriteMerchantOfferViewModel.allOffers.count
                                        self.isShowProgressViewOffer = true
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                        
                        Spacer().frame(height: 40)
                        
                    }.padding()
                }
            }
        }
    }
}

struct FavoriteMerchantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMerchantDetailView(merchantId: 1)
    }
}
