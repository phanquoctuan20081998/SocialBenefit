//
//  InternalNewsCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 11/08/2021.
//

import SwiftUI

struct InternalNewsCardView: View {
    
    @Binding var isActive: Bool
    @Binding var selectedInternalNew: InternalNewsData
    
    var internalNewsData: InternalNewsData
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isActive.toggle()
                self.selectedInternalNew = internalNewsData
            }, label: {
                HStack {
                    URLImageView(url: internalNewsData.cover)
                        .frame(width: 100)
                        .cornerRadius(20)
                        .padding(.all, 15)
                    
                    Spacer()

                    VStack(alignment: .leading, spacing: 5) {
                        Text(internalNewsData.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        
                        Text(internalNewsData.shortBody)
                            .font(.subheadline)
                            .italic()
                            .lineLimit(2)
                    }.frame(width: ScreenInfor().screenWidth * 0.8 - 130, alignment: .leading)
                    .padding(.trailing, 20)
                    
                    Spacer()
                }
            })
        }
        .frame(width: ScreenInfor().screenWidth * 0.9)
        .foregroundColor(.black)
        .background(Color(#colorLiteral(red: 0.9544095397, green: 0.9545691609, blue: 0.9543884397, alpha: 1)))
        .cornerRadius(20)
        .padding(.horizontal)
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 3, y: 3)
    }
}
