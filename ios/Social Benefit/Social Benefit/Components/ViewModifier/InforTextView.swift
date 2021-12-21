//
//  ErrorTextView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import SwiftUI

struct InforTextView: View {
    var text: String
    @Binding var isPresent: Bool
    
    var textColor: Color
    var backgroundColor: Color
    
    var image: Image?
    
    var body: some View {
        VStack() {
            HStack(spacing: 10) {
                if let image = image {
                    Button(action: {
                        isPresent = false
                    }, label: {
                        image
                            .foregroundColor(textColor)
                            .font(Font.system(size: 25))
                    })
                }
                Text(text)
                    .foregroundColor(textColor)
                    .font(.system(size: 15))
                    .lineLimit(3)
            }
            .padding(10)
            .background(backgroundColor)
            .clipShape(Capsule())
        }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 50, trailing: 10))
    }
}

struct InforTextView_Previews: PreviewProvider {
    static var previews: some View {
        InforTextView.init(text: "jhjhkjhkhkhkhkhkh", isPresent: .constant(true), textColor: .white, backgroundColor: .red, image: Image(systemName: "xmark"))
    }
}
