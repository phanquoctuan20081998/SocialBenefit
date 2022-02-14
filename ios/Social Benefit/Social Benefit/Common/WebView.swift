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
    
    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func goBack(){
        webview?.goBack()
    }
    
    func goForward(){
        webview?.goForward()
    }
}
