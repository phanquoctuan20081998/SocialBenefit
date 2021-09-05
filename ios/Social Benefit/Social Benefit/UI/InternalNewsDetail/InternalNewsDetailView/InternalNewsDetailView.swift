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
    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            PostContentView
            LikeAndCommentCount
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            LikeAndCommentButton
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            
            let _ = print(commentViewModel.parentComment.count)
            
            ScrollView(.vertical, showsIndicators: false) {
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
                .frame(width: 40, height: 40)
                .padding(.all, 7)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 10)
            
            VStack {
                Text(comment.commentDetail)
                    .font(.system(size: 15))
                    .lineLimit(5)
                    .padding()
                    .frame(width: ScreenInfor().screenWidth * 0.7, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2)))
                
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
    }
}

struct SecondCommentCardView: View {
    
    var comment: CommentData
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer().frame(width: 70)
            URLImageView(url: comment.avatar)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.all, 7)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 20)
            
            VStack {
                Text(comment.commentDetail)
                    .font(.system(size: 15))
                    .lineLimit(5)
                    .padding()
                    .frame(width: ScreenInfor().screenWidth * 0.55, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2)))
                
                HStack {
                    Text(comment.commentTime)
                        .font(.system(size: 13))
                    
                    Spacer()
                }.foregroundColor(.black.opacity(0.6))
                .padding(.leading)
            }
        }.padding(.horizontal)
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
                    .overlay(RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    .overlay(Image(systemName: "arrow.up.circle.fill")
                                .padding(.trailing, 3)
                                .foregroundColor(.blue)
                                .font(.system(size: 23)),
                             alignment: .trailing)
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
        InternalNewsDetailView(internalNewData: InternalNewsData())
    }
}
