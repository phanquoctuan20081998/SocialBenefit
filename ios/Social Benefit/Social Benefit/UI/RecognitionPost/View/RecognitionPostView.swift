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
    
    @ObservedObject var commentEnvironment = CommentEnvironmentObject()
    
    @State var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    var companyData: RecognitionData = RecognitionData.sampleData[0]
    
    @State var activeSheet: ReactActiveSheet?
    
    init(companyData: RecognitionData) {
        self.reactViewModel = ReactViewModel(myReact: companyData.getMyReact(), reactTop1: companyData.getReactTop1(), reactTop2: companyData.getReactTop2())
        
        self.recognitionPostViewModel = RecognitionPostViewModel(id: companyData.getId())
        
        self.companyData = companyData
        self.recognitionPostViewModel.numOfComment = companyData.getCommentCount()
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
                
                RefreshableScrollView(height: 70, refreshing: self.$recognitionPostViewModel.isRefreshing) {
                    AmzdScrollViewReader { proxy in
                        VStack {
                            PostContentView
                                .onAppear { self.proxy = proxy }
                            CommentView
                            Spacer()
                        }
                    }
                    Spacer().frame(height: 30)
                }
                
                CommentInputView(contentId: recognitionPostViewModel.contentId, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION)
                    .environmentObject(commentEnvironment)
            }
            .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "recognition".localized, isHaveLogo: true))
            .environmentObject(recognitionPostViewModel)
            .environmentObject(reactViewModel)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                recognitionPostViewModel.numOfComment = self.companyData.getCommentCount()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .overlay(CommentPopup().environmentObject(commentEnvironment))
            .overlay(DeleteCommentPopup().environmentObject(commentEnvironment))
            .overlay(EditCommentPopup().environmentObject(commentEnvironment))
            .overlay(CommentReactPopup().environmentObject(commentEnvironment))
            .sheet(item: $activeSheet) { item in
                switch item {
                case .content:
                    ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION, contentId: recognitionPostViewModel.contentId)
                case .comment:
                    ReactionPopUpView(activeSheet: $activeSheet, contentType: Constants.CommentContentType.COMMENT_TYPE_COMMENT, contentId: commentEnvironment.commentId)
                }
            }
            .errorPopup($commentEnvironment.error)
            // Reaction Bar
            if reactViewModel.isShowReactionBar {
                ReactionBarView(isShowReactionBar: $reactViewModel.isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
                    .offset(x: -30, y: 0)
                    .zIndex(2)
            }
        }
    }
}

extension RecognitionPostView {
    
    var PostContentView: some View {
        VStack(spacing: 15) {
            PostBannerView()
            
            Spacer().frame(height: 5)
            
            LikeAndCommentCountBarView(numOfComment: recognitionPostViewModel.numOfComment, contentType: Constants.ReactContentType.RECOGNIZE, totalOtherReact: recognitionPostViewModel.recognitionData.getTotalOtherReact())
                .padding(.horizontal, 10)
            
            Rectangle()
                .foregroundColor(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth * 0.95, height:  1)
            
            LikeAndCommentButton(contentId: companyData.getId(), contentType: Constants.ReactContentType.RECOGNIZE, isFocus: $recognitionPostViewModel.isFocus)
                .frame(height: 10)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
            
            Rectangle()
                .foregroundColor(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth * 0.95, height:  1)
        }
    }
    
    var CommentView: some View {
        VStack {
            if recognitionPostViewModel.isLoading && !recognitionPostViewModel.isRefreshing {
                LoadingPageView()
            } else {
                VStack(spacing: 10) {
                    
                    Spacer().frame(height: 100)
                    
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
