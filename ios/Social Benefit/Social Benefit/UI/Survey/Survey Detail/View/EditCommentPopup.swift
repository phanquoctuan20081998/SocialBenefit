//
//  EditCommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct EditCommentPopup: ViewModifier {
    
    @Binding var comment: CommentResultModel?
    
    @Binding var newText: String
    
    var action: (() -> Void)
    
    init(_ comment: Binding<CommentResultModel?>, newText: Binding<String>, action: @escaping (() -> Void)) {
        _comment = comment
        _newText = newText
        self.action = action
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
                    HStack {

                        AutoResizeTextField(text: $newText, isFocus: .constant(true), minHeight: 30, maxHeight: 100, placeholder: "")
                        Button {
                            action()
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.system(size: 25))
                        }
                        .disabled(newText.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
                    }
                    .padding()
                    .frame(width: ScreenInfor().screenWidth * 0.8)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                    )
                }
                .offset(y: -100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.black.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    newText = ""
                    comment = nil
                }
            }
        }
    }
}

extension View {
    
    func editDeletePopup(_ comment: Binding<CommentResultModel?>, newText: Binding<String>, action: @escaping (() -> Void)) -> some View {
        return modifier(EditCommentPopup.init(comment, newText: newText, action: action))
    }
}
