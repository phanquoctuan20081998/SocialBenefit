//
//  EditCommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct EditCommentPopup: View {
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject
    
    var body: some View {
        GeometryReader { geometry in
            if commentEnvironment.commentEdited != nil {
                VStack {
                    HStack {

                        AutoResizeTextField(text: $commentEnvironment.newComment, isFocus: .constant(true), minHeight: 30, maxHeight: 100, placeholder: "")
                        Button {
                            commentEnvironment.updateComment()
                        } label: {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.system(size: 25))
                        }
                        .disabled(commentEnvironment.newComment.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
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
                    commentEnvironment.newComment = ""
                    commentEnvironment.commentEdited = nil
                }
                .errorPopup($commentEnvironment.error)
                .loadingView(isLoading: $commentEnvironment.isLoading)
            }
        }
    }
}
