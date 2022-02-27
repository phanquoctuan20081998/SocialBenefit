//
//  InformationView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/09/2021.
//

import SwiftUI

struct InformationTabView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    
    var body: some View {
        VStack {
            Webview(dynamicHeight: .constant(0), htmlString: merchantVoucherDetailViewModel.merchantVoucherDetail.content + "<p><strong>\("Hotline".localized):&nbsp;\(merchantVoucherDetailViewModel.merchantVoucherDetail.hotlines)</strong></p>", font: 0)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
        }.frame(width: ScreenInfor().screenWidth)
    }
}
