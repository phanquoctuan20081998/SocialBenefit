//
//  CommentBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/11/2021.
//

import SwiftUI

struct CommentBarView: View {
    
    // Optional - if comment don't need rely just init isReply = false, replyTo = "", parentId = -1
    @Binding var isReply: Bool
    @Binding var replyTo: String
    @Binding var parentId: Int
    @Binding var isFocus: Bool
    @Binding var commentText: String
    
    // Need to rewrite send button for individual task
    var SendButtonView: AnyView
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 3) {
                
                if isReply {
                    HStack {
                        Text("reply_to".localized)
                        Text(replyTo)
                        Text(" - ")
                        
                        Button(action: {
                            isReply = false
                            parentId = -1
                        }, label: {
                            Text("cancel".localized)
                                .fontWeight(.bold)
                        })
                        
                    }.font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                
                HStack {
                    URLImageView(url: Config.baseURL + userInfor.avatar)
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .padding(.all, 2)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    Spacer().frame(width: 18)
                    
                    AutoResizeTextField(text: $commentText, isFocus: $isFocus, minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    
                    SendButtonView
                }
            }
        }.background(Color.white)
    }
}


