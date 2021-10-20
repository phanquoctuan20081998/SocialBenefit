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
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(20)
                        .padding(.all, 15)
                    
                    Spacer().frame(width: 10)

                    VStack(alignment: .leading, spacing: 5) {
                        Text(internalNewsData.title.toUpperCase())
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text(internalNewsData.shortBody)
                            .font(.subheadline)
                            .font(.system(size: 13))
                            .italic()
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    Spacer()
                }.frame(height: 100)
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

struct InternalCardView_Previews : PreviewProvider {
    static var previews: some View {
        InternalNewsCardView(isActive: .constant(true), selectedInternalNew: .constant(InternalNewsData(id: 1, contentId: 1, title: "sad", shortBody: "fscs", body: "Svsv", cover: "", newsCategory: 1)), internalNewsData: InternalNewsData(id: 2, contentId: 1, title: "training quản lí thời gian tdcn", shortBody: "dzxcbsbchsbchjsdbchbshcbhsdbchdsbchbdschbdhcbhsdbchsbchbbcshdbchsbdchbsdhcbhjdsbchdsbchbdchbdhcbhjsbchsdbchsbdchsbchbshcbhbsv", body: "SDcs", cover: "/files/4077/chandung.png", newsCategory: 1))
            .environmentObject(InternalNewsViewModel())
    }
}
