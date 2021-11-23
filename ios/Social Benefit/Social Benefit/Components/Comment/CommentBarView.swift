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
    
    @Binding var commentText: String
    
    // Need to rewrite send button for individual task
    var SendButtonView: AnyView
    
    var body: some View {
        VStack {
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            
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
                        .padding(.leading, 70)
                }
                
                HStack {
                    URLImageView(url: Config.baseURL + userInfor.avatar)
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .padding(.all, 7)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    Spacer().frame(width: 18)
                    
                    AutoResizeTextField(text: $commentText, isFocus: .constant(false), minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(5)
                    
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    
                    SendButtonView
                }
            }.padding(.top, 5)
        }.padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
}


