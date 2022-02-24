//
//  ReactionBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/01/2022.
//

import SwiftUI

struct ReactionBar: View {
    
    @Binding var isShowReactionBar: Bool
    @Binding var isLoadingReact: Bool
    @Binding var currentReaction: ReactionType
    @Binding var isFocus: Bool
    @Binding var activeSheet: ReactActiveSheet?
    
    var reactModel: ReactSuveryModel
    var listComment: ListCommentModel
    
    var sendReaction: () -> ()
    
    var body: some View {
        VStack {
            HStack() {
                if isLoadingReact {
                    ActivityRep()
                } else {
                    HStack(spacing: 0) {
                        ForEach(reactModel.maxReactionType.indices) { index in
                            if index < reactModel.maxReactionType.count {
                                if reactModel.maxReactionType[index] != .none {
                                    Image.init(reactModel.maxReactionType[index].imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }
                    
                    Text(reactModel.allReactionText)
                        .font(Font.system(size: 12))
                        .onTapGesture {
                            activeSheet = .content
                        }
                }
                
                Spacer()
                
                if let commentCount = listComment.result?.count {
                    Text(commentCount.string + " " + "count_comment".localized)
                        .font(Font.system(size: 12))
                }
            }
            
            Divider()
            
            HStack {
                if isShowReactionBar {
                    ReactionCommentView.init(isShowReactionBar: $isShowReactionBar, selectedReaction: $currentReaction, action: {
                        self.sendReaction()
                    })
                } else {
                    if isLoadingReact {
                        ActivityRep()
                    } else {
                        Button.init {
                            isShowReactionBar = true
                        } label: {
                            HStack {
                                if currentReaction == .none {
                                    Image(systemName: "hand.thumbsup")
                                } else {
                                    Image(currentReaction.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                }
                                Text(reactModel.myReactionText)
                                    .font(Font.system(size: 12))
                                    .foregroundColor(currentReaction.color)
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "bubble.left")
                    Text("comment".localized)
                        .font(Font.system(size: 12))
                }.onTapGesture {
                    isFocus = true
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
    }
}
