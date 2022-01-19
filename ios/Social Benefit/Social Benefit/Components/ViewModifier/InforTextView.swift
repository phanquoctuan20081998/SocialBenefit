//
//  ErrorTextView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import SwiftUI

struct InforTextView: ViewModifier {
    @Binding var text: String
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
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
                        Image(systemName: "info.circle")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        Text(text)
                            .foregroundColor(Color.white)
                            .font(.system(size: 15))
                            .lineLimit(3)
                    }
                    .padding(10)
                    .background(Color.yellow)
                    .clipShape(Capsule())
                }
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 50, trailing: 10))
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                .onTapGesture {
                    text = ""
                }
                .onReceive(timer) { _ in
                    text = ""
                }
                .onAppear {
                    _ = self.timer.upstream.autoconnect()
                }
                .onDisappear {
                    self.timer.upstream.connect().cancel()
                }
            }
        }
    }
}

extension View {
    
    func inforTextView(_ text: Binding<String>) -> some View {
        return modifier(InforTextView.init(text: text))
    }
}
