//
//  InternalNewsDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct InternalNewsDetailView: View {
    
    @ObservedObject var commentViewModel: CommentViewModel
    @ObservedObject var reactViewModel: ReactViewModel
    
    var internalNewData: InternalNewsData
    
    @State var commentText = ""
    @State var isReply: Bool = false
    @State var parentId: Int = -1
    @State var replyTo: String = ""
    @State var isLike: Bool = false
    @State var isShowReactionBar: Bool = false
    @State var selectedReaction: Int = 0
    
    init(internalNewData: InternalNewsData) {
        self.commentViewModel = CommentViewModel(contentId: internalNewData.contentId)
        self.reactViewModel = ReactViewModel(contentId: internalNewData.contentId)
        self.internalNewData = internalNewData
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    VStack {
                        PostContentView
                        LikeAndCommentCount
                        Divider().frame(width: ScreenInfor().screenWidth*0.9)
                        LikeAndCommentButton
                    }.zIndex(0)
                    
                    if isShowReactionBar {
                        ReactionBarView(isShowReactionBar: $isShowReactionBar, selectedReaction: $selectedReaction)
                            .offset(x: -30, y: 90)
                            .zIndex(1)
                    }
                }
               
                Divider().frame(width: ScreenInfor().screenWidth*0.9)
                
                Spacer().frame(height: 20)
                
                VStack(spacing: 10) {
                    
                    let parentCommentMax = commentViewModel.parentComment.indices
                    ForEach(parentCommentMax, id: \.self) { i in
                        
                        FirstCommentCardView(comment: commentViewModel.parentComment[i].data, isReply: $isReply, parentId: $parentId, replyTo: $replyTo)
                        
                        if commentViewModel.parentComment[i].childIndex != -1 {
                            let childIndex = commentViewModel.parentComment[i].childIndex
                            
                            ForEach(0..<commentViewModel.childComment[childIndex].count, id: \.self) { j in
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
    @Binding var isReply: Bool
    @Binding var parentId: Int
    @Binding var replyTo: String
    
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

struct SendCommentButtonView: View {
    
    @ObservedObject var commentViewModel: CommentViewModel
    
    @Binding var isReply: Bool
    
    var contentId: Int
    var parentId: Int
    var content: String
    
    var body: some View {
        Button(action: {
            AddCommentService().getAPI(contentId: contentId, parentId: parentId, content: content)
            sleep(1)
            
            let newComment = CommentData(id: newCommentId, contentId: contentId, parentId: parentId, avatar: userInfor.avatar, commentBy: userInfor.name, commentDetail: content, commentTime: "a_few_seconds".localized)
            
            commentViewModel.updateComment(newComment: newComment)
            
            self.commentViewModel.numOfComment += 1
        }, label: {
            Image(systemName: "paperplane.circle.fill")
                .padding(.trailing, 3)
                .foregroundColor(content.isEmpty ? .gray : .blue)
                .font(.system(size: 35))
                .background(Color.white)
        })
        .disabled(content.isEmpty)
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
            
            VStack(alignment: .leading, spacing: 3) {
                
                if self.isReply {
                    HStack {
                        Text("reply_to".localized)
                        Text(self.replyTo)
                        Text(" - ")
                        
                        Button(action: {
                            self.isReply = false
                            self.parentId = -1
                        }, label: {
                            Text("cancel".localized)
                                .fontWeight(.bold)
                        })
                        
                    }.font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.leading, 70)
                }
                
                HStack {
                    URLImageView(url: userInfor.avatar)
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
                    
                    SendCommentButtonView(commentViewModel: commentViewModel, isReply: $isReply, contentId: internalNewData.contentId, parentId: parentId, content: commentText)
                }
            }.padding(.top, 5)
        }.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    
    
    var LikeAndCommentCount: some View {
        HStack {
            HStack(spacing: 4) {
                let reactCount = reactViewModel.getTop3React().count
                
                // If there no react
                if reactCount == 0 {
                    HStack {
                        HStack(spacing: 4) {
                            Image("ic_fb_like")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Image("ic_fb_laugh")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }.scaledToFit()
                        
                        Text("be_the_first".localized)
                            .font(.system(size: 12))
                            .bold()
                    }
                    
                    // If it have some react
                } else {
                    HStack {
                        HStack(spacing: 4) {
                            if reactCount > 0 {
                                Image(reactViewModel.getTop3React()[0])
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            if reactCount > 1 {
                                Image(reactViewModel.getTop3React()[1])
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            if reactCount > 2 {
                                Image(reactViewModel.getTop3React()[2])
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }.scaledToFit()
                        
                        Text(String(reactViewModel.numOfReact))
                            .font(.system(size: 12))
                            .bold()
                    }
                }
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
                
                HStack {
                    if self.selectedReaction == 6 {
                        HStack {
                            Image(systemName: "hand.thumbsup\(isLike ? ".fill" : "")" )
                            Text("\((reactViewModel.getTop3React().count == 0) ? "be_the_first".localized : "like".localized)")
                        }.foregroundColor(isLike ? .blue : .black)
                            
                    } else if self.selectedReaction == 0 {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("liked".localized)
                    }
                    
                    else {
                        AnimatedImage(name: reactions[self.selectedReaction])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60,
                                   height: 60)
                    }
                }
                .onTapGesture {
                    self.isLike.toggle()
                }
                .gesture(DragGesture(minimumDistance: 0)
                            .onChanged(onChangedValue(value:))
                            .onEnded(onEndValue(value:)))
            }

            Spacer()
            
            HStack {
                Image(systemName: "bubble.left")
                Text("Comment")
            }
            
        }.padding()
    }
    
    func onChangedValue(value: DragGesture.Value) {
        withAnimation(.easeIn) {isShowReactionBar = true}
        withAnimation(Animation.linear(duration: 0.15)) {
            let x = value.location.x
            
            if x > 10 && x < 70 {self.selectedReaction = 0}
            if x > 70 && x < 120 {self.selectedReaction = 1}
            if x > 120 && x < 180 {self.selectedReaction = 2}
            if x > 180 && x < 230 {self.selectedReaction = 4}
            if x > 230 && x < 280 {self.selectedReaction = 5}
            if x < 10 || x > 280 {self.selectedReaction = 6}
        
        }
    }
    
    func onEndValue(value: DragGesture.Value) {
        withAnimation(Animation.easeOut.delay(0.3)) {
            isShowReactionBar = false
        }
    }
}



struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView(internalNewData: InternalNewsData(id: 0, contentId: 12, title: "Thông báo cắt điện6", shortBody: "Thông báo cắt điện", body: "Test", cover: "/files/608/iphone-11-xanhla-200x200.jpg", newsCategory: 1))
    }
}
