//
//  RecognitionPostView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/11/2021.
//

import SwiftUI
import ScrollViewProxy

struct RecognitionPostView: View {
    
    @ObservedObject var recognitionPostViewModel: RecognitionPostViewModel
    @ObservedObject var reactViewModel: ReactViewModel
    @ObservedObject var keyboardHandler = KeyboardHandler()
    @StateObject var commentEnvironment = CommentEnvironmentObject()
    
    @State var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    @State private var proxy: AmzdScrollViewProxy? = nil
    @State var activeSheet: ReactActiveSheet?
    
    var companyData: RecognitionData = RecognitionData.sampleData[0]
    

    init(companyData: RecognitionData) {
        self.reactViewModel = ReactViewModel(contentId: companyData.getId(), contentType: Constants.ReactContentType.RECOGNIZE)
        self.recognitionPostViewModel = RecognitionPostViewModel(id: companyData.getId())
        self.companyData = companyData
        self.recognitionPostViewModel.numOfComment = companyData.getCommentCount()
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Spacer()
                    .frame(height: 70)
                
                RefreshableScrollView(height: 70, refreshing: self.$recognitionPostViewModel.isRefreshing) {
                    AmzdScrollViewReader { proxy in
                        VStack {
                            PostContentView
                                .onAppear { self.proxy = proxy }
                            ReactionView
                            CommentView
                                .padding(.top, 10)
                            Spacer()
                        }.padding(.bottom, keyboardHandler.keyboardHeight)
                    }
                }
                
                CommentInputView(contentId: recognitionPostViewModel.contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION)
                    .environmentObject(commentEnvironment)
                    .background(Color.white)
//                    .offset(y: -keyboardHandler.keyboardHeight)
            }
            .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "recognition".localized, isHaveLogo: true))
            .environmentObject(recognitionPostViewModel)
            .environmentObject(reactViewModel)
            .onAppear {
                recognitionPostViewModel.numOfComment = self.companyData.getCommentCount()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .overlay(CommentPopup().environmentObject(commentEnvironment))
            .overlay(DeleteCommentPopup().environmentObject(commentEnvironment))
            .overlay(EditCommentPopup().environmentObject(commentEnvironment))
            .overlay(CommentReactPopup().environmentObject(commentEnvironment))
            // Dismiss reaction bar when tab outside
            .onTapGesture {
                if reactViewModel.isShowReactionBar {
                    reactViewModel.isShowReactionBar = false
                }
                Utils.dismissKeyboard()
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .content:
                    ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION, contentId: recognitionPostViewModel.contentId)
                case .comment:
                    ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_COMMENT, contentId: commentEnvironment.commentId)
                }
            }
            .errorPopup($commentEnvironment.error)
        }
    }
}

extension RecognitionPostView {
    
    var PostContentView: some View {
        VStack(spacing: 0) {
            PostBannerView()
            Spacer().frame(height: 5)
        }
    }
    
    var ReactionView: some View {
        VStack {
            ReactionBar(isShowReactionBar: $reactViewModel.isShowReactionBar,
                        isLoadingReact: $reactViewModel.isLoadingReact,
                        currentReaction: $reactViewModel.currentReaction,
                        isFocus: $commentEnvironment.focusComment,
                        activeSheet: $activeSheet,
                        reactModel: reactViewModel.reactModel,
                        listComment: commentEnvironment.listComment,
                        sendReaction: { reactViewModel.sendReaction(contentId: companyData.getId()) })
            
            Rectangle()
                .fill(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth * 0.95, height: 1)
        }
    }
    
    var CommentView: some View {
        VStack {
            if recognitionPostViewModel.isLoading && !recognitionPostViewModel.isRefreshing {
                LoadingPageView()
            } else {
                VStack(spacing: 10) {                    
                    CommentListView.init(contentId: recognitionPostViewModel.contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION, activeSheet: $activeSheet)
                        .environmentObject(commentEnvironment)
                }
            }
        }
    }
    
    func reloadReaction() {
        
    }
}

struct RecognitionPostView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionPostView(companyData: RecognitionData.sampleData[0])
    }
}
