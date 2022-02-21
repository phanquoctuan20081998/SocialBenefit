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
    
    @ObservedObject var commentEnvironment = CommentEnvironmentObject()
    
    @State var activeSheet: ReactActiveSheet?
    
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
            Spacer().frame(height: ScreenInfor().screenHeight * 0.13)
            
            RefreshableScrollView(height: 70, refreshing: self.$commentViewModel.isRefreshing) {
                AmzdScrollViewReader { proxy in
                    ScrollViewContent
                        .onAppear { self.proxy = proxy }
                        .padding(.bottom, keyboardHandler.keyboardHeight)
                        .introspectScrollView { scrollView in
                            if commentEnvironment.scrollToBottom {
                                if scrollView.contentSize.height > scrollView.bounds.size.height {
                                    let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                                    scrollView.setContentOffset(bottomOffset, animated: true)
                                }
                            }
                        }
                }
            }
            
            Spacer()
            
            VStack {                
                CommentInputView.init(contentId: internalNewData.contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS)
                    .environmentObject(commentEnvironment)
                Spacer().frame(height: 10)
            }
            .background(Color.white)
            .offset(y: -keyboardHandler.keyboardHeight)
        }
        .edgesIgnoringSafeArea(.all)
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: true, isHiddenTabBarWhenBack: isHiddenTabBarWhenBack, backButtonTapped: backButtonTapped))
        
        // Dismiss reaction bar when tab outside
        .onTapGesture {
            if reactViewModel.isShowReactionBar {
                reactViewModel.isShowReactionBar = false
            }
            Utils.dismissKeyboard()
        }
        .onAppear(perform: {
            UIScrollView.appearance().bounces = true
        })
        
        // Option pop up
        .overlay(CommentPopup().environmentObject(commentEnvironment))
        .overlay(DeleteCommentPopup().environmentObject(commentEnvironment))
        .overlay(EditCommentPopup().environmentObject(commentEnvironment))
        .overlay(CommentReactPopup().environmentObject(commentEnvironment))
        .sheet(item: $activeSheet) { item in
            switch item {
            case .content:
                ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS, contentId: internalNewData.contentId)
            case .comment:
                ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_COMMENT, contentId: commentEnvironment.commentId)
            }
        }
        .errorPopup($commentEnvironment.error)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func backButtonTapped() {
        if isNavigationFromHomeScreen {
            homeViewModel.isPresentInternalNewDetail = false
            ImageSlideTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
        } else {
            
        }
    }
}


extension InternalNewsDetailView {
    
    var ScrollViewContent: some View {
        VStack {
            ZStack {
                VStack {
                    PostContentView
                    
                    //                    LikeAndCommentCountBarView(numOfComment: commentViewModel.numOfComment)
                    //                        .padding(.horizontal, 10)
//                    Divider().frame(width: ScreenInfor().screenWidth * 0.9)
//                    LikeAndCommentButton(contentId: commentViewModel.contentId, isFocus: $commentViewModel.isFocus)
//                        .frame(height: 20)
//                        .padding(.horizontal, 10)
                    
                    ReactionView
                }
                .zIndex(1)
                .environmentObject(reactViewModel)
                
//                if reactViewModel.isShowReactionBar {
//                    ReactionBarView(isShowReactionBar: $reactViewModel.isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
//                        .offset(x: 100 - ScreenInfor().screenWidth / 3, y: 100 + webViewHeight / 2)
//                        .zIndex(1)
//                }
            }
            
            Divider().frame(width: ScreenInfor().screenWidth * 0.9)
            
            if commentViewModel.isLoading && !commentViewModel.isRefreshing {
                LoadingPageView()
            } else {
                CommentListView.init(contentId: internalNewData.contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS, activeSheet: $activeSheet)
                    .environmentObject(commentEnvironment)
            }
        }
    }
    
    var ReactionView: some View {
        ReactionBar(isShowReactionBar: $reactViewModel.isShowReactionBar,
                    isLoadingReact: $reactViewModel.isLoadingReact,
                    currentReaction: $reactViewModel.currentReaction,
                    isFocus: $commentEnvironment.focusComment,
                    activeSheet: $activeSheet,
                    reactModel: reactViewModel.reactModel,
                    listComment: commentEnvironment.listComment,
                    sendReaction: { reactViewModel.sendReaction(contentId: internalNewData.contentId) })
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
                
                Webview(dynamicHeight: $webViewHeight, htmlString: internalNewData.body, font: 1)
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
    
    @Binding var isReply: Bool
    @Binding var commentText: String
    @Binding var moveToPosition: Int
    @Binding var numOfComment: Int
    @Binding var proxy: AmzdScrollViewProxy?
    
    var contentId: Int
    @Binding var parentId: Int
    var content: String
    var contentType: Int
    
    var updateComment: (_ newComment: CommentData) -> ()
    var otherUpdate: () -> () = { }
    
    var body: some View {
        Button(action: {
            
            // Check content for reply or non-reply comment
            var type = 0
            
            if self.contentType == Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS {
                type = Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS
                if parentId != -1 {
                    type = Constants.CommentContentType.COMMENT_TYPE_COMMENT
                }
            } else {
                type = Constants.CommentContentType.COMMENT_TYPE_RECOGNITION
                if parentId != -1 {
                    type = Constants.CommentContentType.COMMENT_TYPE_COMMENT
                }
            }
            
            AddCommentService().getAPI(contentId: contentId, contentType: type, parentId: parentId, content: content, returnCallBack: { newCommentId in
                DispatchQueue.main.async {
                    let newComment = CommentData(id: newCommentId, contentId: contentId, parentId: parentId, avatar: userInfor.avatar, commentBy: userInfor.nickname.isEmpty ? userInfor.name : userInfor.nickname, commentDetail: content, commentTime: "a_few_seconds".localized)
                    
                    updateComment(newComment)
                    otherUpdate() // If have
                    
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
                    self.numOfComment += 1
                    isReply = false
                    parentId = -1
                }
            })
            
            Utils.dismissKeyboard()
            
            // Click count
            if contentType == Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS {
                countClick(contentId: contentId, contentType: Constants.ViewContent.TYPE_INTERNAL_NEWS)
            } else if contentType == Constants.CommentContentType.COMMENT_TYPE_RECOGNITION {
                countClick(contentId: contentId, contentType: Constants.ViewContent.TYPE_RECOGNITION)
            }
            
        }, label: {
            Image(systemName: "paperplane.circle.fill")
                .padding(.trailing, 3)
                .foregroundColor(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
                .font(.system(size: 35))
                .background(Color.white)
        })
            .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
}


struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView(internalNewData: InternalNewsData(id: 0, contentId: 12, title: "Thông báo cắst điện6", shortBody: "Thông báo cắt điện", body: "<p>それでは申し訳ございません が、 　５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。５分ほど、お時間をいただけますでしょうか。 一度お電話をお切りして、上の者から 改めてお話しさせていただきたいと存じますが、よろしいでしょうか。</p>", cover: "/files/608/iphone-11-xanhla-200x200.jpg", newsCategory: 1))
    }
}
