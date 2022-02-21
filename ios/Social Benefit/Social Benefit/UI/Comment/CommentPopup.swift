//
//  CommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct CommentPopup: View {
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject    
    
    var body: some View {
        GeometryReader { geometry in
            if commentEnvironment.commentSelected != nil {
                VStack {
                    VStack(alignment: .leading) {
                        OptionCardView(image: "square.and.pencil", title: "edit_comment".localized, color: Color.blue)
                            .onTapGesture {
                                commentEnvironment.commentEdited = commentEnvironment.commentSelected
                                commentEnvironment.newComment = commentEnvironment.commentEdited?.commentDetail ?? ""
                                commentEnvironment.commentSelected = nil
                            }
                        
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: ScreenInfor().screenWidth * 0.7, height: 1)
                            .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                        
                        OptionCardView(image: "xmark.bin.fill", title: "delete_comment".localized, color: Color.purple)
                            .onTapGesture {
                                commentEnvironment.commentDeleted = commentEnvironment.commentSelected
                                commentEnvironment.commentSelected = nil
                            }
                    }
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 130, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.black.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    commentEnvironment.commentSelected = nil
                }
            }
        }
    }
    
    @ViewBuilder
    func OptionCardView(image: String, title: String, color: Color) -> some View {
        HStack(spacing: 30) {
            Image(systemName: image)
                .foregroundColor(color)
                .frame(width: ScreenInfor().screenWidth * 0.1)
            
            Text(title)
            
            Spacer()
        }
        .font(.system(size: 17))
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
    }
}
