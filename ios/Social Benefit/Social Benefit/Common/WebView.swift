//
//  WebView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.
//

import SwiftUI
import WebKit

struct URLWebView: UIViewRepresentable {
    
    let request: URLRequest
    var webview: WKWebView?
    @Binding var isLoading: Bool
    
    init(web: WKWebView?, req: URLRequest, isLoading: Binding<Bool>) {
        self.webview = WKWebView()
        self.request = req
        _isLoading = isLoading
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
        }
        uiView.load(request)
    }
    
    func goBack(){
        webview?.goBack()
    }
    
    func goForward(){
        webview?.goForward()
    }
}
