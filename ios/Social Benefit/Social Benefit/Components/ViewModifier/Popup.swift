//
//  Popup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import SwiftUI

struct Popup<T: View>: ViewModifier {
    let popup: T
    @Binding var isPresented: Bool
    let alignment: Alignment
    
    init(isPresented: Binding<Bool>, alignment: Alignment, @ViewBuilder content: () -> T) {
        _isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

extension View {
    func popup<T: View>(isPresented: Binding<Bool>, alignment: Alignment = .center, @ViewBuilder content: () -> T) -> some View {
        return modifier(Popup(isPresented: isPresented, alignment: alignment, content: content))
    }
}
