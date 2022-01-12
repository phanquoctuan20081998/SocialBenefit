//
//  SuccessTextView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 06/01/2022.
//

import Foundation
import SwiftUI

struct SuccessTextView: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if !text.isEmpty {
                VStack() {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        Text(text)
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
                            .lineLimit(3)
                    }
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Capsule())
                }
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 50, trailing: 10))
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                .onTapGesture {
                    text = ""
                }
            }
        }
    }
}

extension View {
    
    func successPopup(_ text: Binding<String>) -> some View {
        return modifier(SuccessTextView.init(text: text))
    }
}
