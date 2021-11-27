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
    @ObservedObject var keyboardHandler = KeyboardHandler()
    
    // For navigation from homescreen
    @EnvironmentObject var homeViewModel: HomeViewModel
    var isNavigationFromHomeScreen: Bool = false
    var isHiddenTabBarWhenBack: Bool
    
    var internalNewData: InternalNewsData
    
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
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            CommentBarView(isReply: $commentViewModel.isReply,
                           replyTo: $commentViewModel.replyTo,
                           parentId: $commentViewModel.parentId,
                           commentText: $commentViewModel.commentText,
                           SendButtonView: AnyView(SendCommentButtonView(commentViewModel: commentViewModel, isReply: $commentViewModel.isReply, commentText: $commentViewModel.commentText, moveToPosition: $commentViewModel.moveToPosition, proxy: $proxy, contentId: internalNewData.contentId, parentId: commentViewModel.parentId, content: commentViewModel.commentText)))
                .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            
            Spacer()
        }
        .padding(.bottom, keyboardHandler.keyboardHeight)
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
                    LikeAndCommentCountBarView(numOfComment: commentViewModel.numOfComment)
                        .padding(.horizontal, 10)
                    Divider().frame(width: ScreenInfor().screenWidth * 0.9)
                    LikeAndCommentButton(contentId: commentViewModel.contentId)
                        .frame(height: 20)
                        .padding(.horizontal, 10)
                }
                .zIndex(1)
                .environmentObject(reactViewModel)
                
                if reactViewModel.isShowReactionBar {
                    ReactionBarView(isShowReactionBar: $reactViewModel.isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
                        .offset(x: -30, y: 100 + webViewHeight)
                        .zIndex(1)
                }
            }
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            Spacer().frame(height: 50)
            
            if commentViewModel.isLoading && !commentViewModel.isRefreshing {
                LoadingPageView()
            } else {
                VStack(spacing: 10) {
                    
                    Spacer().frame(height: 50)
                    
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
                
                Webview(dynamicHeight: $webViewHeight, htmlString: internalNewData.body, font: 22)
                    .frame(width: ScreenInfor().screenWidth * 0.9, height: webViewHeight)
            }
            .padding(.bottom, 20)
            
            
        }
        .frame(width: ScreenInfor().screenWidth * 0.9)
        .background(Color.white)
        .cornerRadius(20)
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
            
            // Check content for reply or non-reply comment
            var contentType = Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS
            if parentId != -1 {
                contentType = Constants.CommentContentType.COMMENT_TYPE_COMMENT
            }
            
            AddCommentService().getAPI(contentId: contentId, contentType: contentType, parentId: parentId, content: content, returnCallBack: { newCommentId in
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


