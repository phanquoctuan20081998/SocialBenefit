//
//  AppliedStoreView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/09/2021.
//

import SwiftUI

struct AppliedStoreView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        
        VStack {
            RefreshableScrollView(height: 70, refreshing: self.$merchantVoucherDetailViewModel.isRefreshingStoreList) {
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
                Spacer().frame(height: 40)
            }
        }
        .frame(width: ScreenInfor().screenWidth)
    }
}
