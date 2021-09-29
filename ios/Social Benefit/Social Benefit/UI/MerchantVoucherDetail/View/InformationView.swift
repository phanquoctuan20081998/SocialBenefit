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
            HTMLView(htmlString: merchantVoucherDetailViewModel.merchantVoucherDetail.content + "<p><strong>\("hotline".localized):&nbsp;\(merchantVoucherDetailViewModel.merchantVoucherDetail.hotlines)</strong></p>")
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
        }.frame(width: ScreenInfor().screenWidth)
    }
}
