//
//  CommentCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/09/2021.
//

import SwiftUI

struct FirstCommentCardView: View {
    
    var comment: CommentData
    var currentPosition: Int
    
    @Binding var isReply: Bool
    @Binding var parentId: Int
    @Binding var replyTo: String
    @Binding var moveToPosition: Int
    
    var body: some View {
        HStack(alignment: .top) {
            URLImageView(url: comment.avatar)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .padding(.all, 5)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 10)
            
            VStack {
                
                VStack(alignment: .leading) {
                    Text(comment.commentBy)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.init(top: 15, leading: 15, bottom: 0, trailing: 0))
                    
                    Spacer().frame(height: 10)
                    Text(comment.commentDetail)
                        .font(.system(size: 15))
                        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 0))
                }.frame(width: ScreenInfor().screenWidth * 0.75, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 13)
                                .fill(Color.gray.opacity(0.2)))
                
                Spacer().frame(height: 5)
                
                HStack() {
                    Button(action: {
                        self.isReply = true
                        self.parentId = comment.id
                        self.replyTo = comment.commentBy
                        self.moveToPosition = self.currentPosition
                    }, label: {
                        Text("reply".localized)
                            .bold()
                            .font(.system(size: 13))
                    })
                    
                    Text(comment.commentTime)
                        .font(.system(size: 13))
                    
                    Spacer()
                }.foregroundColor(.black.opacity(0.6))
                .padding(.leading)
            }
        }.padding(.horizontal)
        .padding(.top, 5)
        // This offset will help text bar not cover new comment...
        // Because scrollView only scroll to top of final comment card
        .offset(y: -100)
    }
}

struct SecondCommentCardView: View {
    
    var comment: CommentData
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer().frame(width: 70)
            URLImageView(url: Config.baseURL + comment.avatar)
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .padding(.all, 5)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 10)
            
            VStack {
                VStack(alignment: .leading) {
                    Text(comment.commentBy)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.init(top: 15, leading: 15, bottom: 0, trailing: 15))
                    
                    Spacer().frame(height: 10)
                    Text(comment.commentDetail)
                        .font(.system(size: 15))
                        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 15))
                }.frame(width: ScreenInfor().screenWidth * 0.56, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 13)
                                .fill(Color.gray.opacity(0.2)))
                
                Spacer().frame(height: 5)
                
                HStack {
                    Text(comment.commentTime)
                        .font(.system(size: 13))
                    
                    Spacer()
                }.foregroundColor(.black.opacity(0.6))
                .padding(.leading)
            }
        }.padding(.horizontal)
        .padding(.top, 5)
        .offset(y: -100)
    }
}

struct CommentCardView_Previews: PreviewProvider {
    static var previews: some View {
        FirstCommentCardView(comment: CommentData(id: 1, contentId: 1, parentId: -1, avatar: "", commentBy: "tt", commentDetail: "sdfhbsdjhfbsdhjbfhjsd", commentTime: ""), currentPosition: 1, isReply: .constant(false), parentId: .constant(-1), replyTo: .constant(""), moveToPosition: .constant(12))
    }
}
