//
//  HTML.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import WebKit
import SwiftUI

struct HTMLView: UIViewRepresentable {
    var htmlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let headerString = convertToHTMLString(htmlString)
        
        uiView.loadHTMLString(headerString, baseURL: nil)
    }

}

struct Webview : UIViewRepresentable {
    
    @Binding var dynamicHeight: CGFloat
    var htmlString: String
    var font: Int
    var webview: WKWebView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

            
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            let css = "img { max-width: 100%; height: auto; width: 100%; }"
            
            webView.evaluateJavaScript("var style = document.createElement('style'); style.innerHTML = '\(css)'; document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.dynamicHeight = height as! CGFloat
                }
            })
        }
    }
    
    func webViewDidFinishLoad(webView: WKWebView) {
        webView.frame.size.width = ScreenInfor().screenWidth * 0.9
//         webView.frame.size = webView.sizeThatFits(CGSize.zero)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=0.5, user-scalable=no, shrink-to-fit=no\"></HEAD><BODY>"
        let htmlEnd = "</font></BODY></HTML>"
        let html = convertToHTMLString(htmlString)   
        let htmlString = "\(htmlStart)\(html)\(htmlEnd)"
        webview.loadHTMLString(htmlString, baseURL:  nil)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}


