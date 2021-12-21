//
//  LoadingView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import SwiftUI
import UIKit

struct UIActivityRep: UIViewRepresentable {
    var style: UIActivityIndicatorView.Style = .large
    var color: UIColor = .white
    
    func makeUIView(context: UIViewRepresentableContext<UIActivityRep>) -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.style = style
        activity.color = color
        return activity
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<UIActivityRep>) {
        uiView.startAnimating()
    }
}

struct LoadingView: View {
    var body: some View {
        VStack() {
            UIActivityRep()
        }
        .padding(25)
        .background(Color.black.opacity(0.6))
        .cornerRadius(10)
    }
}

extension View {
    func loadingView(isLoading: Binding<Bool>) -> some View {
        return self.popup(isPresented: isLoading, alignment: .center) {
            VStack {
                LoadingView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.black.opacity(0.2))
            .edgesIgnoringSafeArea(.all)
        }
    }
}
