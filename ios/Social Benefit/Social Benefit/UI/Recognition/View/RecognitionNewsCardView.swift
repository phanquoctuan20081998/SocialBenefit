//
//  RecognitionNewsCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import SwiftUI
import ScrollViewProxy

struct RecognitionNewsCardView: View {
    
    @ObservedObject var reactViewModel: ReactViewModel
    @StateObject var commentEnvironment = CommentEnvironmentObject()
    
    @State var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    @State var commentText: String = ""
    @State var commentCount: Int = 0
    @State var activeSheet: ReactActiveSheet?
    
    @Binding private var proxy: AmzdScrollViewProxy?
    
    var companyData: RecognitionData = RecognitionData.sampleData[0]
    var index: Int = 0
    var newsFeedType: Int = 0
    
    var isHaveReactAndCommentButton: Bool = true
    
    init(companyData: RecognitionData, index: Int, proxy: Binding<AmzdScrollViewProxy?>, newsFeedType: Int, isHaveReactAndCommentButton: Bool) {
        self.reactViewModel = ReactViewModel(myReact: companyData.getMyReact(), reactTop1: companyData.getReactTop1(), reactTop2: companyData.getReactTop2())
            
        _proxy = proxy
        
        self.companyData = companyData
        self.commentCount = companyData.getCommentCount()
        self.index = index
        self.newsFeedType = newsFeedType
        self.isHaveReactAndCommentButton = isHaveReactAndCommentButton
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 10) {
                ContentView
                
                if !isHaveReactAndCommentButton {
                    LikeAndCommentCountBarView(numOfComment: commentCount, contentType: Constants.ReactContentType.RECOGNIZE, totalOtherReact: companyData.getTotalOtherReact())
                }
                
                if isHaveReactAndCommentButton {
                    ReactionBar(isShowReactionBar: $reactViewModel.isShowReactionBar,
                                isLoadingReact: $reactViewModel.isLoadingReact,
                                currentReaction: $reactViewModel.currentReaction,
                                isFocus: $commentEnvironment.focusComment,
                                activeSheet: $activeSheet,
                                reactModel: reactViewModel.reactModel,
                                listComment: commentEnvironment.listComment,
                                isOnlyLike: true,
                                sendReaction: { reactViewModel.sendReaction(contentId: companyData.getId()) })
                    
                    CommentBarView(isReply: .constant(false), replyTo: .constant(""), parentId: .constant(-1), isFocus: .constant(false), commentText: $commentText, SendButtonView: AnyView(SendCommentButtonView))
                        .onTapGesture {
                            self.proxy?.scrollTo(self.index, alignment: .top, animated: true)
                        }
                }
            }
            .environmentObject(reactViewModel)
            .padding()
            .font(.system(size: 14))

        }.onAppear {
            self.commentCount = self.companyData.getCommentCount()
        }
    }
}

extension RecognitionNewsCardView {
    
    var ContentView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                
                if newsFeedType == Constants.RecognitionNewsFeedType.ALL {
                    Text("\(companyData.getTime()), \(getDateSinceToday(time:companyData.getDate()).localized)")
                } else {
                    Text("\(companyData.getTime())")
                }
                
                Spacer()
                
                Text("\(companyData.getPoint() > 0 ? "+" : "")\(companyData.getPoint())")
                    .bold()
                    .foregroundColor(companyData.getPoint() > 0 ? .blue : .gray)
            }
            
            Text("**\(companyData.getFrom())** \("to".localized) **\(companyData.getTo())**")
                .fixedSize(horizontal: false, vertical: true)
            
            Text(companyData.getMessage())
                .italic()
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    var SendCommentButtonView: some View {
        Button(action: {
            AddCommentService().getAPI(contentId: companyData.getId(), contentType: Constants.CommentContentType.COMMENT_TYPE_RECOGNITION, parentId: -1, content: commentText, returnCallBack: { newCommentId in
                DispatchQueue.main.async {
                    self.commentText = ""
                    self.commentCount += 1
                }
            })
            
            // Click count
            countClick(contentId: companyData.getId(), contentType: Constants.ViewContent.TYPE_RECOGNITION)
        }, label: {
            Image(systemName: "paperplane.circle.fill")
                .padding(.trailing, 3)
                .foregroundColor(commentText.isEmpty ? .gray : .blue)
                .font(.system(size: 30))
                .background(Color.white)
        })
            .disabled(commentText.isEmpty)
    }
}


struct RecognitionNewsCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionNewsCardView(companyData: RecognitionData.sampleData[0], index: 0, proxy: .constant(nil), newsFeedType: 0, isHaveReactAndCommentButton: true)
    }
}
