//
//  URLImageView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/09/2021.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct URLImageView: View {
    @State var isAnimating: Bool = true
    
    var url: String
    var isDefaultAvatar: Bool = false
    
    init(url: String) {
        if url.contains("http") {
            self.url = url
        } else {
            self.url = Config.baseURL + url
        }
        
        self.url = self.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    init(url: String, isDefaultAvatar: Bool) {
        if url.contains("http") {
            self.url = url
        } else {
            self.url = Config.baseURL + url
        }
        
        self.url = self.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        self.isDefaultAvatar = isDefaultAvatar
    }
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: url), isAnimating: $isAnimating)
                .placeholder {
                    Rectangle().foregroundColor(.gray.opacity(0.1))
                        .overlay(
                            ZStack {
                                if isDefaultAvatar {
                                    Image("pic_user_profile")
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                            }
                        )
                }
                .resizable()
                .scaledToFill()
                .clipped()
        }
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(url: "/files/3576/logo.png")
            .frame(width: 300, height: 100)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
