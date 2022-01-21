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
    var url: String
    
    var body: some View {
        WebView
    }
}

extension MerchantWebView {
    
    var WebView: some View {
        
        let webview = URLWebView(web: nil, req: URLRequest(url: URL(string: url)!), isLoading: $isLoading)
        
        return VStack {
            HStack {
//                Button {
//                    if webview.webview?.url == URL(string: url)! {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
//
//                    webview.goBack()
//                } label: {
//                    Image(systemName: "arrow.backward")
//                        .foregroundColor(.blue)
//                        .font(.system(size: 20))
//                }
                
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
            .background(Color.white.opacity(0.0001))
            
            webview
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct MerchantWebView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantWebView(isLoading: .constant(false), url: "https://ptitrangan.com.vn/embed-app/?partner=nev&uid=%501%5D")
    }
}
