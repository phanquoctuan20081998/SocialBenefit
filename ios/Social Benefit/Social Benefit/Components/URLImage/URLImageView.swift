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
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    // Fallback on earlier versions
                    Text("Loading")
                }
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

