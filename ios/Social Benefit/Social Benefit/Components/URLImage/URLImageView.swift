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
    
//    @ObservedObject var vm: URLImageViewModel
//
//    init(url: String) {
//        _vm = ObservedObject(wrappedValue: URLImageViewModel(url: url))
//    }
    @State var isAnimating: Bool = true
    var url: String
    
    init(url: String) {
        if url.contains("http") {
            self.url = url
        } else {
            self.url = Config.baseURL + url
        }
    }
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: url), isAnimating: $isAnimating)
                .placeholder {
                    Rectangle().foregroundColor(.gray.opacity(0.1))
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray.opacity(0.5))
                        )
//                        .scaledToFill()
                }
                .resizable()
                .scaledToFill()
                
                            
            
//            if let image = vm.image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//
//            } else if vm.isLoading {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.1))
//                    .overlay(
//                        Image(systemName: "photo")
//                                .foregroundColor(.gray.opacity(0.5))
//                    )
//
//            } else {
//                Image(systemName: "questionmark")
//                    .foregroundColor(Color.gray)
//            }
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

