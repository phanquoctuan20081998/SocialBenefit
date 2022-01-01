//
//  ErrorPupup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import SwiftUI

struct ErrorTextView: ViewModifier {
    
    @Binding var error: AppError
    
    init(_ error: Binding<AppError>) {
        _error = error
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if error != .none {
                VStack() {
                    HStack(spacing: 10) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        Text(error.text)
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
                            .lineLimit(3)
                    }
                    .padding(10)
                    .background(Color.red)
                    .clipShape(Capsule())
                }
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 50, trailing: 10))
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                .onTapGesture {
                    error = .none
                }
                .onReceive(PopUpTimer) { _ in
                    error = .none
                }
            }
        }
    }
}

extension View {
    
    func errorPopup(_ error: Binding<AppError>) -> some View {
        return modifier(ErrorTextView.init(error))
    }
}

