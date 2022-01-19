//
//  VinaphoneView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI

struct PTIView: View {
    
    var webViewURL: String
    
    var body: some View {
        MerchantWebView(url: webViewURL)
    }
}


struct PTIView_Previews: PreviewProvider {
    static var previews: some View {
        PTIView(webViewURL: "https://ptitrangan.com.vn/embed-app/?partner=nev&uid=%501%5D")
    }
}
