//
//  RoundedButton.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct RoundedButton: View {
    
    var text: String
    var font: Font
    var backgroundColor: Color
    var textColor: Color
    var cornerRadius: CGFloat
    
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .font(font)
            .minimumScaleFactor(0.5)
            .padding(.all, 10)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(text: "Apply", font: .system(size: 30, weight: .black, design: .default), backgroundColor: Color.blue, textColor: Color.white, cornerRadius: 30)
    }
}
