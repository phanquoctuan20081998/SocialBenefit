//
//  SimiliarVoucherView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/09/2021.
//

import SwiftUI

struct SimiliarVoucherView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer().frame(height: 20)
                VStack(spacing: 10) {
                    ForEach(merchantVoucherDetailViewModel.similarVouchers.indices, id: \.self) { i in
                        NavigationLink(
                            destination: MerchantVoucherDetailView(voucherId: merchantVoucherDetailViewModel.similarVouchers[i].id),
                            label: {
                                AllOfferCardView(voucherData: merchantVoucherDetailViewModel.similarVouchers[i])
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                            })
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
