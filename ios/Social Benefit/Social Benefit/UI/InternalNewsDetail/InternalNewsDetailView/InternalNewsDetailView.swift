//
//  InternalNewsDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/08/2021.
//

import SwiftUI

struct InternalNewsDetailView: View {
    
    @ObservedObject var commentViewModel: CommentViewModel
    var internalNewData: InternalNewsData
    @State var commentText = ""
    
    
    init(internalNewData: InternalNewsData) {
        self.commentViewModel = CommentViewModel(index: internalNewData.contentId)
        self.internalNewData = internalNewData
    }
    
    
    //DEBUG
//    let parent = [ParentCommentData(data: CommentData(id: 253, contentId: 172, parentId: Optional(-1), avatar: "/files/523/freepressjournal_2020-08_ab6e6d11-54d6-4723-a883-5c6817f6fca3_anchor.jpg", commentBy: "Quang Tran Dinh", commentDetail: "aaaaaaaa", commentTime: "20 hours"), childIndex: 0)]
//
//    let child = [[CommentData(id: 254, contentId: 172, parentId: Optional(253), avatar: "/files/523/freepressjournal_2020-08_ab6e6d11-54d6-4723-a883-5c6817f6fca3_anchor.jpg", commentBy: "Quang Tran Dinh", commentDetail: "bbwfwfwejhfbhjwebfhbwehfbwehjbfhwebfhbwehfbwhjbfhjwebfhjwbehjfbwhejfbwehbfhwebfhjbwejhfbwefbbbbbb", commentTime: "20 hours")]]
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            ScrollView(.vertical, showsIndicators: false) {
                PostContentView
                LikeAndCommentCount
                Divider().frame(width: ScreenInfor().screenWidth*0.9)
                LikeAndCommentButton
                Divider().frame(width: ScreenInfor().screenWidth*0.9)
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 10) {
                    
                    let parentCommentMax = commentViewModel.parentComment.indices
                    ForEach(parentCommentMax, id: \.self) { i in

                        FirstCommentCardView(comment: commentViewModel.parentComment[i].data)

                        if commentViewModel.parentComment[i].childIndex != -1 {
                            let childIndex = commentViewModel.parentComment[i].childIndex

                            ForEach(0..<commentViewModel.childComment[childIndex].count) { j in
                                SecondCommentCardView(comment: commentViewModel.childComment[childIndex][j])
                            }
                        }
                    }
                    
                    //DEBUG
//                    let parentCommentMax = parent.indices
//                    ForEach(parentCommentMax, id: \.self) { i in
//
//                        FirstCommentCardView(comment: parent[i].data)
//
//                        if parent[i].childIndex != -1 {
//                            let childIndex = parent[i].childIndex
//
//                            ForEach(0..<child[childIndex].count) { j in
//                                SecondCommentCardView(comment: child[childIndex][j])
//                            }
//                        }
//                    }
                    
                }
            }
            
            Spacer()
            
            CommentBarView
            
        }.background(NoSearchBackgroundView(isActive: .constant(true)))
    }
}

struct FirstCommentCardView: View {
    
    var comment: CommentData
    
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
    }
}

struct SecondCommentCardView: View {
    
    var comment: CommentData
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer().frame(width: 70)
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
    }
}

extension InternalNewsDetailView {
    
    var PostContentView: some View {
        VStack {
            URLImageView(url: internalNewData.cover)
                .frame(width: ScreenInfor().screenWidth*0.8, height: 150)
                .padding()
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(internalNewData.title)
                        .bold()
                        .font(.system(size: 20))
                        .lineLimit(2)
                    Text(internalNewData.body)
                        .lineLimit(5)
                }
                Spacer()
            }.padding(.horizontal)
            .padding(.bottom)
        }.frame(width: ScreenInfor().screenWidth*0.9)
        .background(Color.white)
        .cornerRadius(20)
        
    }
    
    var CommentBarView: some View {
        VStack {
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            HStack {
                Image("pic_user_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.all, 7)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                Spacer().frame(width: 18)
                
                TextField("Comment", text: $commentText)
                    .padding(5)
                    .padding(.leading, 10)
                    .overlay(Image(systemName: "arrow.up.circle.fill")
                                .padding(.trailing, 3)
                                .foregroundColor(.blue)
                                .font(.system(size: 23))
                                .background(Color.white),
                             alignment: .trailing)
                    .overlay(RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    
            }.padding(.horizontal)
        }
    }
    
    var LikeAndCommentCount: some View {
        
        HStack {
            HStack {
                HStack(spacing: 4) {
                    Image("ic_fb_like")
                        .resizable()
                    Image("ic_fb_laugh")
                        .resizable()
                }.scaledToFit()
                .frame(width: 40)
                
                Text("10 người khác thích")
                    .font(.system(size: 12))
                    .bold()
            }
            
            Spacer()
            
            Text("\(commentViewModel.numOfComment)" + " comments".localized)
                .font(.system(size: 12))
                .bold()
        }.padding(.horizontal)
    }
    
    var LikeAndCommentButton: some View {
        HStack {
            HStack {
                Image(systemName: "hand.thumbsup")
                Text("Like")
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "bubble.left")
                Text("Comment")
            }
        }.padding()
    }
}



struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView(internalNewData: InternalNewsData(id: 0, contentId: 12, title: "Thông báo cắt điện6", shortBody: "Thông báo cắt điện", body: "Test", cover: "/files/608/iphone-11-xanhla-200x200.jpg", newsCategory: 1))
    }
}
