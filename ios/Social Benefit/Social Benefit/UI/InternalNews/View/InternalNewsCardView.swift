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
                
                // Click count
                countClick(contentId: self.internalNewsData.contentId, contentType: Constants.ViewContent.TYPE_INTERNAL_NEWS)
            }, label: {
                HStack(alignment: .top) {
                    URLImageView(url: internalNewsData.cover)
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(17)
                        .padding(.all, 14)
                    
                    Spacer().frame(width: 6)

                    VStack(alignment: .leading, spacing: 5) {
                        Text(internalNewsData.title.toUpperCase())
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        
                        Text(internalNewsData.shortBody)
                            .font(.subheadline)
                            .font(.system(size: 13))
                            .italic()
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                    }.padding(.vertical)
                    Spacer()
                }.frame(height: 100)
            })
        }
        .frame(width: ScreenInfor().screenWidth * 0.9)
        .foregroundColor(.black)
        .background(Color.gray.opacity(0.1))
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 3, y: 3)
    }
}

struct InternalCardView_Previews : PreviewProvider {
    static var previews: some View {
        InternalNewsCardView(isActive: .constant(true), selectedInternalNew: .constant(InternalNewsData(id: 1, contentId: 1, title: "sad", shortBody: "fscs", body: "Svsv", cover: "", newsCategory: 1)), internalNewsData: InternalNewsData(id: 2, contentId: 1, title: "training quản lí thời gian tdcn dsj fjf sdsjfk dsfd kdfkd ", shortBody: "dzxcbsbch sdcsdcnjndcjscj ndcjns dcnbchjsdb", body: "SDcs", cover: "/files/4077/chandung.png", newsCategory: 1))
            .environmentObject(InternalNewsViewModel())
    }
}
