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
    @State var isShowReactionBar: Bool = false
    
    @State var previousReaction: Int = 6
    
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
                        ReactionBarView(isShowReactionBar: $isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
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
                    
                    AutoResizeTextField(text: $commentText, minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(5)
                        
                        .overlay(RoundedRectangle(cornerRadius: 20)
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
                    if !self.reactViewModel.isLike {
                        HStack {
                            Image(systemName: "hand.thumbsup")
                            Text("\((reactViewModel.getTop3React().count == 0) ? "be_the_first".localized : "like".localized)")
                        }.foregroundColor(.black)
                        
                    } else {
                        if self.reactViewModel.selectedReaction == 6 {
                            HStack {
                                Image(systemName: "hand.thumbsup.fill")
                                Text("liked".localized)
                            }.foregroundColor(.blue)
                            
                        } else if self.reactViewModel.selectedReaction == 0 {
                            HStack {
                                Image(systemName: "hand.thumbsup.fill")
                                Text("liked".localized)
                            }.foregroundColor(.blue)
                            
                        } else {
                            HStack {
                                AnimatedImage(name: reactions[self.reactViewModel.selectedReaction] + ".gif")
                                    .customLoopCount(2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                                Text(reactions[self.reactViewModel.selectedReaction].localized)
                                    .foregroundColor(reactionColors[self.reactViewModel.selectedReaction])
                            }
                        }
                    }
                }.frame(height: 40)
                .onTapGesture {
                    if self.reactViewModel.isLike {
                        
                        //Update delete reaction on server
                        AddReactService().getAPI(contentId: commentViewModel.contentId, contentType: 1, reactType: self.reactViewModel.selectedReaction)
                        
                        self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] -= 1
                        self.reactViewModel.numOfReact -= 1
                        self.reactViewModel.selectedReaction = 6
                        
                    } else {
                        
                        self.reactViewModel.selectedReaction = 0
                        self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] += 1
                        self.reactViewModel.numOfReact += 1
                        
                        //Update delete uncheck reaction on server
                        AddReactService().getAPI(contentId: commentViewModel.contentId, contentType: 1, reactType: self.reactViewModel.selectedReaction)
                        self.previousReaction = self.reactViewModel.selectedReaction
                    }
                    self.reactViewModel.isLike.toggle()
                    
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
        }.padding(.horizontal)
    }
    
    func onChangedValue(value: DragGesture.Value) {
        withAnimation(.easeIn) {self.isShowReactionBar = true}
        withAnimation(Animation.linear(duration: 0.15)) {
            let x = value.location.x
            
            if x > 10 && x < 70 {self.reactViewModel.selectedReaction = 0}
            if x > 70 && x < 120 {self.reactViewModel.selectedReaction = 1}
            if x > 120 && x < 180 {self.reactViewModel.selectedReaction = 2}
            if x > 180 && x < 230 {self.reactViewModel.selectedReaction = 4}
            if x > 230 && x < 280 {self.reactViewModel.selectedReaction = 5}
        }
    }
    
    func onEndValue(value: DragGesture.Value) {
        withAnimation(Animation.easeOut.delay(0.2)) {
            if !self.reactViewModel.isLike {
                self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] += 1
                self.reactViewModel.numOfReact += 1
            }
            else {
                self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] += 1
                self.reactViewModel.reactCount[self.previousReaction] -= 1
            }
            
            self.isShowReactionBar = false
            self.reactViewModel.isLike = true
            
            //Update reaction on server
            AddReactService().getAPI(contentId: commentViewModel.contentId, contentType: 1, reactType: self.reactViewModel.selectedReaction)
            self.previousReaction = self.reactViewModel.selectedReaction
        }
    }
}



struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView(internalNewData: InternalNewsData(id: 0, contentId: 12, title: "Thông báo cắt điện6", shortBody: "Thông báo cắt điện", body: "Test", cover: "/files/608/iphone-11-xanhla-200x200.jpg", newsCategory: 1))
    }
}
