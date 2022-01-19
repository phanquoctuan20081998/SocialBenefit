//
//  MerchantWebView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 19/01/2022.
//

import SwiftUI

struct MerchantWebView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var url: String
    
    var body: some View {
        WebView
    }
}

extension MerchantWebView {
    
    var WebView: some View {
        
        let webview = URLWebView(web: nil, req: URLRequest(url: URL(string: url)!))
        
        return VStack {
            HStack {
                Button {
                    if webview.webview?.url == URL(string: url)! {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    webview.goBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
            }
            .padding(.top, ScreenInfor().screenHeight * 0.05)
            .padding()
            .background(Color.white)
            
            webview
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct MerchantWebView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantWebView(url: "https://ptitrangan.com.vn/embed-app/?partner=nev&uid=%501%5D")
    }
}
