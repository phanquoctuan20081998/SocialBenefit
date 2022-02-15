//
//  VinaphoneView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI

struct PTIView: View {
    
    @State var isLoading: Bool = true
    var webViewURL: String
    var merchantName: String
    
    var body: some View {
        ZStack {
            MerchantWebView(isLoading: $isLoading, merchantSpecialCode: Constants.MerchantSpecialCode.PTI, url: webViewURL)
            
            if isLoading {
                MerchantLoadingView(merchantName: merchantName)
            }
        }
    }
}


struct PTIView_Previews: PreviewProvider {
    static var previews: some View {
        PTIView(webViewURL: "https://ptitrangan.com.vn/embed-app/?partner=nev&uid=%501%5D", merchantName: "PTI")
    }
}
