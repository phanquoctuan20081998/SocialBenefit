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
    
    @State var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    var companyData: RecognitionData = RecognitionData.sampleData[0]
    
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
                
                
                CommentBarView(isReply: $recognitionPostViewModel.isReply,
                               replyTo: $recognitionPostViewModel.replyTo,
                               parentId: $recognitionPostViewModel.parentId,
                               isFocus: $recognitionPostViewModel.isFocus,
                               commentText: $recognitionPostViewModel.commentText,
                               SendButtonView: AnyView(
                                SendCommentButtonView(
                                    isReply: $recognitionPostViewModel.isReply,
                                    commentText: $recognitionPostViewModel.commentText,
                                    moveToPosition: $recognitionPostViewModel.moveToPosition,
                                    numOfComment: $recognitionPostViewModel.numOfComment,
                                    proxy: $proxy,
                                    contentId: recognitionPostViewModel.contentId,
                                    parentId: recognitionPostViewModel.parentId,
                                    content: recognitionPostViewModel.commentText,
                                    contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION,
                                    updateComment: recognitionPostViewModel.updateComment(newComment: ))))
                    .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                    .padding(.bottom, keyboardHandler.keyboardHeight)
                
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
                    
                    let parentCommentMax = recognitionPostViewModel.parentComment.indices
                    ForEach(parentCommentMax, id: \.self) { i in
                        
//                        VStack {
//                            FirstCommentCardView(comment: recognitionPostViewModel.parentComment[i].data, currentPosition: i, isReply: $recognitionPostViewModel.isReply, parentId: $recognitionPostViewModel.parentId, replyTo: $recognitionPostViewModel.replyTo, moveToPosition: $recognitionPostViewModel.moveToPosition)
//
//                            if recognitionPostViewModel.parentComment[i].childIndex != -1 {
//                                let childIndex = recognitionPostViewModel.parentComment[i].childIndex
//
//                                ForEach(0..<recognitionPostViewModel.childComment[childIndex].count, id: \.self) { j in
//                                    SecondCommentCardView(comment: recognitionPostViewModel.childComment[childIndex][j])
//                                }
//                            }
//                        }.scrollId(i)
                    }
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
