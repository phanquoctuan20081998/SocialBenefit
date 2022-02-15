//
//  MerchantWebView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 19/01/2022.
//

import SwiftUI

struct MerchantWebView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLoading: Bool
    var merchantSpecialCode: String
    var url: String
    
    var body: some View {
        WebView
    }
}

extension MerchantWebView {
    
    var WebView: some View {
        
        let webview = URLWebView(web: nil, req: URLRequest(url: URL(string: url)!), isLoading: $isLoading)
        
        return ZStack(alignment: .top) {
 
            webview
            
            HStack {
                
                // Show close button on the rignt side in VNP
                if merchantSpecialCode == Constants.MerchantSpecialCode.VNP || merchantSpecialCode == Constants.MerchantSpecialCode.VUI {
                    Spacer()
                }
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 25))
                }
                
                // Show close button on the rignt side in PTI
                if merchantSpecialCode == Constants.MerchantSpecialCode.PTI {
                    Spacer()
                }
            }
            .padding(.top, ScreenInfor().screenHeight * 0.05)
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct MerchantWebView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantWebView(isLoading: .constant(false), merchantSpecialCode: "VNP", url: "https://ptitrangan.com.vn/embed-app/?partner=nev&uid=01")
    }
}
