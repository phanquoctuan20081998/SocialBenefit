//
//  CommentInputView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 26/01/2022.
//

import Foundation
import SwiftUI

struct CommentInputView: View {
    
    var contentId: Int
    
    var contentType: Int
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack(alignment: .center, spacing: 10) {
                URLImageView(url: Config.baseURL + userInfor.avatar, isDefaultAvatar: true)
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.all, 3)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                VStack(alignment: .leading) {
                    if commentEnvironment.replyTo != nil {
                        HStack {
                            Text("reply_to".localized)
                                .font(Font.system(size: 12))
                            Text(commentEnvironment.replyTo?.commentBy ?? "")
                                .font(Font.system(size: 12))
                            Text("-")
                                .font(Font.system(size: 12))
                            Button.init {
                                commentEnvironment.replyTo = nil
                            } label: {
                                Text("cancel".localized)
                                    .font(Font.system(size: 12))
                            }
                            
                        }
                    }
                    HStack {
                        AutoResizeTextField(text: $commentEnvironment.commentString, isFocus: $commentEnvironment.focusComment, minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized, maxLength: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                            .disabled(commentEnvironment.isSendingComment)
                        if commentEnvironment.isSendingComment {
                            ActivityRep()
                        } else {
                            Button.init {
                                Utils.dismissKeyboard()
                                commentEnvironment.sendComment(contentId: contentId, contentType: contentType)
                                if contentType == Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS {
                                    countClick(contentId: contentId, contentType: Constants.ViewContent.TYPE_INTERNAL_NEWS)
                                } else if contentType == Constants.CommentContentType.COMMENT_TYPE_RECOGNITION {
                                    countClick(contentId: contentId, contentType: Constants.ViewContent.TYPE_RECOGNITION)
                                }
                            } label: {
                                Image(systemName: "paperplane.circle.fill")
                                    .padding(.trailing, 3)
                                    .font(.system(size: 35))
                                    .background(Color.white)
                            }
                            .disabled(commentEnvironment.commentString.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
                        }
                    }
                }
                
            }
            .background(Color.white)
            .padding(10)
        }
    }
}
