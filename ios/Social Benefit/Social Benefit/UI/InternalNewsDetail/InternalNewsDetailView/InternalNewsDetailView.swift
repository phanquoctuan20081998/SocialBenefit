//
//  InternalNewsDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import ScrollViewProxy

struct InternalNewsDetailView: View {
    
    @ObservedObject var commentViewModel: CommentViewModel
    @ObservedObject var reactViewModel: ReactViewModel
    
    // For navigation from homescreen
    @EnvironmentObject var homeViewModel: HomeViewModel
    var isNavigationFromHomeScreen: Bool = false
    var isHiddenTabBarWhenBack: Bool
    
    var internalNewData: InternalNewsData
    
    @State var previousReaction: Int = 6
    @State private var proxy: AmzdScrollViewProxy? = nil
    @State private var webViewHeight: CGFloat = .zero
    
    init(internalNewData: InternalNewsData, isHiddenTabBarWhenBack: Bool, isNavigationFromHomeScreen: Bool) {
        self.commentViewModel = CommentViewModel(contentId: internalNewData.contentId)
        self.reactViewModel = ReactViewModel(contentId: internalNewData.contentId)
        self.internalNewData = internalNewData
        self.isHiddenTabBarWhenBack = isHiddenTabBarWhenBack
        self.isNavigationFromHomeScreen = isNavigationFromHomeScreen
    }
    
    init(internalNewData: InternalNewsData, isHiddenTabBarWhenBack: Bool) {
        self.commentViewModel = CommentViewModel(contentId: internalNewData.contentId)
        self.reactViewModel = ReactViewModel(contentId: internalNewData.contentId)
        self.internalNewData = internalNewData
        self.isHiddenTabBarWhenBack = isHiddenTabBarWhenBack
    }
    
    init(internalNewData: InternalNewsData) {
        self.commentViewModel = CommentViewModel(contentId: internalNewData.contentId)
        self.reactViewModel = ReactViewModel(contentId: internalNewData.contentId)
        self.internalNewData = internalNewData
        self.isHiddenTabBarWhenBack = true
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
            
            RefreshableScrollView(height: 70, refreshing: self.$commentViewModel.isRefreshing) {
                AmzdScrollViewReader { proxy in
                    ScrollViewContent
                        .onAppear { self.proxy = proxy }
                }
                Spacer().frame(height: 30)
            }
            
            Spacer()
            
            CommentBarView
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: true, isHiddenTabBarWhenBack: isHiddenTabBarWhenBack, backButtonTapped: backButtonTapped))
    }
    
    func backButtonTapped() {
        if isNavigationFromHomeScreen {
            homeViewModel.isPresentInternalNewDetail = false
            ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        }
    }
}


extension InternalNewsDetailView {
    
    var ScrollViewContent: some View {
        VStack {
            ZStack {
                VStack {
                    PostContentView
                    LikeAndCommentCount
                    Divider().frame(width: ScreenInfor().screenWidth * 0.9)
                    LikeAndCommentButton
                }.zIndex(0)
                
                if reactViewModel.isShowReactionBar {
                    ReactionBarView(isShowReactionBar: $reactViewModel.isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
                        .offset(x: -30, y: 50 + webViewHeight)
                        .zIndex(1)
                }
            }
            
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            
            Spacer().frame(height: 110)
            
            
            if commentViewModel.isLoading && !commentViewModel.isRefreshing {
                LoadingPageView()
            } else {
                VStack(spacing: 10) {
                    
                    let parentCommentMax = commentViewModel.parentComment.indices
                    ForEach(parentCommentMax, id: \.self) { i in
                        
                        VStack {
                            FirstCommentCardView(comment: commentViewModel.parentComment[i].data, currentPosition: i, isReply: $commentViewModel.isReply, parentId: $commentViewModel.parentId, replyTo: $commentViewModel.replyTo, moveToPosition: $commentViewModel.moveToPosition)
                            
                            if commentViewModel.parentComment[i].childIndex != -1 {
                                let childIndex = commentViewModel.parentComment[i].childIndex
                                
                                ForEach(0..<commentViewModel.childComment[childIndex].count, id: \.self) { j in
                                    SecondCommentCardView(comment: commentViewModel.childComment[childIndex][j])
                                }
                            }
                        }.scrollId(i)
                    }
                }
            }
        }
    }
    
    var PostContentView: some View {
        
        VStack {
            URLImageView(url: Config.baseURL + internalNewData.cover)
                .scaledToFit()
                .frame(width: ScreenInfor().screenWidth * 0.8, height: 200)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(internalNewData.title.toUpperCase())
                    .bold()
                    .font(.system(size: 19))
                    .padding(.horizontal, 10)
                
                //                    HTMLView(htmlString: internalNewData.body)
                Webview(dynamicHeight: $webViewHeight, htmlString: internalNewData.body, font: 22)
                    .frame(width: ScreenInfor().screenWidth * 0.9, height: webViewHeight)
            }
            .padding(.bottom, 20)
            
            
        }.frame(width: ScreenInfor().screenWidth * 0.9)
            .background(Color.white)
            .cornerRadius(20)
        
    }
    
    var CommentBarView: some View {
        VStack {
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            
            VStack(alignment: .leading, spacing: 3) {
                
                if commentViewModel.isReply {
                    HStack {
                        Text("reply_to".localized)
                        Text(commentViewModel.replyTo)
                        Text(" - ")
                        
                        Button(action: {
                            commentViewModel.isReply = false
                            commentViewModel.parentId = -1
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
                    
                    AutoResizeTextField(text: $commentViewModel.commentText, isFocus: .constant(false), minHeight: 30, maxHeight: 80, placeholder: "type_comment".localized)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(5)
                    
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    
                    
                    SendCommentButtonView(commentViewModel: commentViewModel, isReply: $commentViewModel.isReply, commentText: $commentViewModel.commentText, moveToPosition: $commentViewModel.moveToPosition, proxy: $proxy, contentId: internalNewData.contentId, parentId: commentViewModel.parentId, content: commentViewModel.commentText)
                }
            }.padding(.top, 5)
        }.padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
    }
    
    
    
    var LikeAndCommentCount: some View {
        HStack {
            HStack(spacing: 4) {
                let reactCount = reactViewModel.getTop3React().count
                
                // If there no react
                if reactCount == 0 {
                    EmptyView()
                    
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
                        
                        if self.reactViewModel.isLike {
                            Text(self.reactViewModel.numOfReact == 1 ? "you".localized : "you_and %d".localizeWithFormat(arguments: self.reactViewModel.numOfReact - 1))
                                .font(.system(size: 12))
                                .bold()
                        } else {
                            Text(self.reactViewModel.numOfReact == 1 ? "%d other".localizeWithFormat(arguments: self.reactViewModel.numOfReact) : "%d others".localizeWithFormat(arguments: self.reactViewModel.numOfReact))
                                .font(.system(size: 12))
                                .bold()
                        }
                    }
                }
            }
            
            Spacer()
            
            if commentViewModel.numOfComment == 1 {
                Text("\(commentViewModel.numOfComment)" + " " + "count_comment".localized)
                    .font(.system(size: 12))
                    .bold()
            } else {
                Text("\(commentViewModel.numOfComment)" + " " + "count_comments".localized)
                    .font(.system(size: 12))
                    .bold()
            }
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
                                .font(.system(size: 12))
                        }.foregroundColor(.black)
                        
                    } else {
                        if self.reactViewModel.selectedReaction == 6 {
                            HStack {
                                Image(systemName: "hand.thumbsup.fill")
                                Text("liked".localized)
                                    .font(.system(size: 12))
                            }.foregroundColor(.blue)
                            
                        } else if self.reactViewModel.selectedReaction == 0 {
                            HStack {
                                Image(systemName: "hand.thumbsup.fill")
                                Text("liked".localized)
                                    .font(.system(size: 12))
                            }.foregroundColor(.blue)
                            
                        } else {
                            HStack {
                                Image("ic_fb_" + reactions[self.reactViewModel.selectedReaction])
                                //                                AnimatedImage(name: reactions[self.reactViewModel.selectedReaction] + ".gif")
                                //                                    .customLoopCount(2)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30,
                                           height: 30)
                                Text(reactions[self.reactViewModel.selectedReaction].localized)
                                    .foregroundColor(reactionColors[self.reactViewModel.selectedReaction])
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }.frame(height: 40)
                    .onTapGesture {
                        if self.reactViewModel.isLike {
                            
                            //Update delete reaction on server
                            AddReactService().getAPI(contentId: commentViewModel.contentId, contentType: Constants.ReactContentType.INTERNAL_NEWS, reactType: self.reactViewModel.selectedReaction)
                            
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
                Text("comment".localized)
                    .font(.system(size: 12))
            }
        }.padding(.horizontal)
    }
    
    func onChangedValue(value: DragGesture.Value) {
        withAnimation(.easeIn) {reactViewModel.isShowReactionBar = true}
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
            
            reactViewModel.isShowReactionBar = false
            reactViewModel.isLike = true
            
            //Update reaction on server
            AddReactService().getAPI(contentId: commentViewModel.contentId, contentType: 1, reactType: self.reactViewModel.selectedReaction)
            self.previousReaction = self.reactViewModel.selectedReaction
        }
    }
}


struct SendCommentButtonView: View {
    
    @ObservedObject var commentViewModel: CommentViewModel
    
    @Binding var isReply: Bool
    @Binding var commentText: String
    @Binding var moveToPosition: Int
    @Binding var proxy: AmzdScrollViewProxy?
    
    var contentId: Int
    var parentId: Int
    var content: String
    
    var body: some View {
        Button(action: {
            AddCommentService().getAPI(contentId: contentId, parentId: parentId, content: content, returnCallBack: { newCommentId in
                DispatchQueue.main.async {
                    let newComment = CommentData(id: newCommentId, contentId: contentId, parentId: parentId, avatar: userInfor.avatar, commentBy: userInfor.name, commentDetail: content, commentTime: "a_few_seconds".localized)
                    
                    commentViewModel.updateComment(newComment: newComment)
                    
                    // Move to the latest comment...
                    // if comment not reply anything
                    if parentId == -1 {
                        if let proxy = proxy {
                            DispatchQueue.main.async {
                                proxy.scrollTo(.bottom, animated: true)
                            }
                        }
                    } else {
                        if let proxy = proxy {
                            DispatchQueue.main.async {
                                proxy.scrollTo(self.moveToPosition,
                                               alignment: .bottom,
                                               animated: true)
                            }
                        }
                    }
                    
                    self.commentText = ""
                    self.commentViewModel.numOfComment += 1
                }
            })
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


struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView(internalNewData: InternalNewsData(id: 0, contentId: 12, title: "Thông báo cắst điện6", shortBody: "Thông báo cắt điện", body: "<p>それでは申し訳ございません が、 　５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。</p>", cover: "/files/608/iphone-11-xanhla-200x200.jpg", newsCategory: 1))
    }
}


