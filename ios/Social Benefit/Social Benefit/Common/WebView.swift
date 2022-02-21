//  WebView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/01/2022.

import SwiftUI
import WebKit

struct URLWebView : UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView?
    @Binding var isLoading: Bool

    init(web: WKWebView?, req: URLRequest, isLoading: Binding<Bool>) {
        self.webview = WKWebView()
        self.request = req
        self._isLoading = isLoading
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: URLWebView
        @Binding var isLoading: Bool

        init(_ parent: URLWebView, isLoading: Binding<Bool>) {
            self.parent = parent
            self._isLoading = isLoading
        }

        // Delegate methods go here

        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            // alert functionality goes here
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.isLoading = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, isLoading: $isLoading)
    }

    func makeUIView(context: Context) -> WKWebView  {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        uiView.load(request)
    }

    func goBack(){
        webview?.goBack()
    }

    func goForward(){
        webview?.goForward()
    }

    func reload(){
        webview?.reload()
    }
}


