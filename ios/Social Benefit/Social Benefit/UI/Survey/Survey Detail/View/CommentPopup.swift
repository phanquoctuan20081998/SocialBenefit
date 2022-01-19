//
//  CommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct CommentPopup: ViewModifier {
    
    @Binding var comment: CommentResultModel?
    @Binding var deleteComment: CommentResultModel?
    @Binding var editComment: CommentResultModel?
    @Binding var newText: String
    
    init(_ comment: Binding<CommentResultModel?>, editCommet: Binding<CommentResultModel?>, deleteComment: Binding<CommentResultModel?>, newText: Binding<String>) {
        _comment = comment
        _editComment = editCommet
        _deleteComment = deleteComment
        _newText = newText
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if comment != nil {
                VStack {
                    VStack(alignment: .leading) {
                        OptionCardView(image: "square.and.pencil", title: "edit_comment".localized, color: Color.blue)
                            .onTapGesture {
                                editComment = comment
                                newText = editComment?.commentDetail ?? ""
                                comment = nil
                            }
                        
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: ScreenInfor().screenWidth * 0.7, height: 1)
                            .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                        
                        OptionCardView(image: "xmark.bin.fill", title: "delete_comment".localized, color: Color.purple)
                            .onTapGesture {
                                deleteComment = comment
                                comment = nil
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
                    comment = nil
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
        }
        .font(.system(size: 20))
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .background(Color.white)
    }
}

extension View {
    
    func commentPopup(_ comment: Binding<CommentResultModel?>, editCommet: Binding<CommentResultModel?>, deleteComment: Binding<CommentResultModel?>, newText: Binding<String>) -> some View {
        return modifier(CommentPopup(comment, editCommet: editCommet, deleteComment: deleteComment, newText: newText))
    }
}
