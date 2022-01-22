//
//  VinaphoneView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI

struct VinaphoneView: View {
    @State var isLoading: Bool = true
    var webViewURL: String
    var merchantName: String
    
    var body: some View {
        ZStack {
            MerchantWebView(isLoading: $isLoading, merchantSpecialCode: Constants.MerchantSpecialCode.VNP, url: webViewURL)
            
            if isLoading {
                MerchantLoadingView(merchantName: merchantName)
            }
        }
    }
}

struct VinaphoneView_Previews: PreviewProvider {
    static var previews: some View {
        VinaphoneView(webViewURL: "http://222.252.19.197:8694/vnpt_online/portal/source/embed/nissho", merchantName: "VNPT")
    }
}
