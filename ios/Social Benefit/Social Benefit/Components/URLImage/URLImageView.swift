//
//  URLImageView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/09/2021.
//

import SwiftUI
import UIKit

struct URLImageView: View {
    
    @ObservedObject var vm: URLImageViewModel
    
    init(url: String) {
        _vm = ObservedObject(wrappedValue: URLImageViewModel(url: url))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    
            } else if vm.isLoading {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .overlay(
                        Image(systemName: "photo")
                                .foregroundColor(.gray.opacity(0.5))
                    )
      
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(url: "/files/3576/logo.png")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

