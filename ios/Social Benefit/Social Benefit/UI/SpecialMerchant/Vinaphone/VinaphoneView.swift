//
//  VinaphoneView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI

struct VinaphoneView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var webViewURL: String
    
    var body: some View {
        VNPWebView
    }
}

extension VinaphoneView {
    
    var VNPWebView: some View {
        
        let webview = URLWebView(web: nil, req: URLRequest(url: URL(string: webViewURL)!))
        
        return VStack {
            
            webview
                .overlay(
                    HStack {
                        Button {
                            if webview.webview?.url == URL(string: webViewURL)! {
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
                        .background(Color.white),
                    alignment: .topLeading
                )
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct VinaphoneView_Previews: PreviewProvider {
    static var previews: some View {
        VinaphoneView(webViewURL: "http://222.252.19.197:8694/vnpt_online/portal/source/embed/nissho")
    }
}
