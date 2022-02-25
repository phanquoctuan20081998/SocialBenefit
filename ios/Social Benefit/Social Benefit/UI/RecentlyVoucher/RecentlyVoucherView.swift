//
//  RecentlyVoucherDetail.swift
//  Social Benefit
//
//  Created by chu phuong dong on 21/02/2022.
//

import SwiftUI

struct RecentlyVoucherView: View {
    
    @StateObject private var viewModel = RecentlyVoucherViewModel()
    
    @State private var isMoveToMerchantDetail = false
    
    @State private var selectedVoucherId = 0
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 50)
            ScrollView(.vertical) {
                
                VStack(spacing: 0) {
                    ForEach(viewModel.list.indices, id: \.self) { i in
                        let item = viewModel.list[i]
                        Button {
                            if item.canBuy == true {
                                self.isMoveToMerchantDetail = true
                                self.selectedVoucherId = item.id
                                
                                // Click count
                                countClick(contentId: item.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                            }
                            
                        } label: {
                            voucherView(item)
                        }
                        .buttonStyle(NavigationLinkNoAffectButtonStyle())
                        .onAppear {
                            if item == viewModel.list.last {
                                viewModel.request()
                            }
                        }
                    }
                    
                    if viewModel.isLoading {
                        UIActivityRep.init(style: .medium, color: .black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }                
            }
            .loadingView(isLoading: $viewModel.isLoadingBuyInfor, dimBackground: false)
        }
        .background(BackgroundViewWithMyVoucher.init(title: "recent_view_voucher".localized))
        .background(
            ZStack {
                NavigationLink(
                    destination: NavigationLazyView(MerchantVoucherDetailView(voucherId: self.selectedVoucherId)),
                    isActive: $isMoveToMerchantDetail,
                    label: {
                        EmptyView()
                    })
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
        .navigationBarHidden(true)
        .errorPopup($viewModel.error)
        .overlay(BuyVoucherView.init(buyInforModel: $viewModel.buyInforModel, voucherId: $viewModel.voucherBuyId))
    }
        
    @ViewBuilder
    func voucherView(_ item: RecentlyVoucherResultModel) -> some View {
        VStack {
            HStack {
                URLImageView(url: item.imgLink)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(10)
                
                Spacer().frame(width: 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(item.voucherTilte)
                        .font(.system(size: 13))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)

                    loveAndCartCountView(item)
                    
                    discountView(item)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
        
    }

    @ViewBuilder
    func loveAndCartCountView(_ item: RecentlyVoucherResultModel) -> some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "suit.heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                Text(item.favoriteValue?.string ?? "")
                    .font(.system(size: 13))
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            
            HStack(spacing: 2) {
                Image(systemName: "cart")
                    .foregroundColor(.blue)
                    .font(.system(size: 13))
                Text(item.shoppingValue?.string ?? "")
                    .font(.system(size: 13))
            }
        }
        .frame(width: 150, alignment: .leading)
    }
    
    @ViewBuilder
    func discountView(_ item: RecentlyVoucherResultModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.pointValueText)
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 11))
                
                HStack {
                    Text(item.moneyValueText)
                        .strikethrough()
                        .font(.system(size: 11))
                    
                    Text(item.discountValueText)
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.orange))
                }
            }
            
            Spacer()
            
            if item.canBuy == true {
                Button(action: {
                    viewModel.requestBuyInfo(id: item.id)
                    // Click count
                    countClick(contentId: item.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                }, label: {
                    Text("buy".localized)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.blue)
                                        .shadow(color: .black.opacity(0.2), radius: 2, x: -0.5, y: 0.5))
                })
            } else {
                Text("the_end".localized)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: -0.5, y: 0.5))
            }
            
        }.padding(.trailing, 20)
    }
}
