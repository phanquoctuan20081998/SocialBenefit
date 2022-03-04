//
//  CommentListView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/01/2022.
//

import SwiftUI

struct CommentListView: View {
    
    var contentId: Int
    
    var contentType: Int
    
    @State var lastLocation: CGPoint = .zero
    
    @Binding var activeSheet: ReactActiveSheet?
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(commentEnvironment.listComment.comments) { comment in
                HStack(alignment: .top) {
                    URLImageView(url: Config.baseURL + (comment.avatar ?? ""), isDefaultAvatar: true)
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .padding(.all, 5)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        commmentDetail(comment)
                        commmentActionBar(comment)
                    }
                    
                }
                .padding(EdgeInsets.init(top: 0, leading: 20, bottom: 10, trailing: 20))
                .fixedSize(horizontal: false, vertical: true)
                
                ForEach(comment.children ?? []) { child in
                    HStack(alignment: .top) {
                        URLImageView(url: Config.baseURL + (child.avatar ?? ""), isDefaultAvatar: true)
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                            .padding(.all, 5)
                            .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            commmentDetail(child)
                            commmentActionBar(child, isChild: true)
                        }
                        
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 70, bottom: 10, trailing: 20))
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onAppear() {
            commentEnvironment.requestListComment(id: contentId, contentType: contentType)
        }
    }
    
    @ViewBuilder
    func commmentDetail(_ comment: CommentResultModel) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(comment.commentBy ?? "")
                .bold()
                .padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                .font(Font.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
            Text(comment.commentDetail ?? "")
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                .font(Font.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)
        }
        .background(Color("comment"))
        .cornerRadius(15)
        .if(comment.commentByEmployeeId?.string == userInfor.employeeId, transform: { content in
            content
                .onTapGesture {
                    
                }
                .onLongPressGesture {
                    commentEnvironment.didLongTapCommnet(comment)
                }
        })
        
    }
    
    @ViewBuilder
    func commmentActionBar(_ comment: CommentResultModel, isChild: Bool = false) -> some View {
        GeometryReader { geometryReader in
            let rect = geometryReader.frame(in: .global)
            HStack {
                Button(action: {
                    commentEnvironment.commentPosition = rect
                    commentEnvironment.commentReacted = comment
                }, label: {
                    if comment.reactionType == .none {
                        Text("like".localized)
                            .bold()
                            .font(Font.system(size: 14))
                            .foregroundColor(Color.gray)
                    } else {
                        Text(comment.reactionType.text)
                            .bold()
                            .font(Font.system(size: 14))
                            .foregroundColor(comment.reactionType.color)
                    }
                    
                })
                
                if !isChild {
                    Button(action: {
                        commentEnvironment.replyTo = comment
                        commentEnvironment.focusComment = true
                    }, label: {
                        Text("reply".localized)
                            .bold()
                            .font(Font.system(size: 14))
                    })
                }
                    
                Text(comment.timeText)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color.gray)
                
                Spacer()
                if !comment.rectCountText.isEmpty {
                    HStack() {
                        Text(comment.rectCountText)
                            .font(Font.system(size: 14))
                            .foregroundColor(Color.gray)                        
                        HStack(spacing: 0, content: {
                            if comment.reactionTypeTop1 != .none {
                                Image.init(comment.reactionTypeTop1.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            }
                            if comment.reactionTypeTop2 != .none {
                                Image.init(comment.reactionTypeTop2.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                            }
                        })
                    }
                    .onTapGesture {
                        commentEnvironment.commentId = comment.id
                        activeSheet = .comment
                    }
                }
            }
        }
        
    }
}

