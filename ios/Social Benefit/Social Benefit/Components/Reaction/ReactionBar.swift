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
    
    var reactModel: ReactSuveryModel
    var listComment: ListCommentModel
    
    var sendReaction: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                if isLoadingReact {
                    ActivityRep()
                } else {
                    if currentReaction != .none {
                        Image.init(currentReaction.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    Text(reactModel.allReactionText)
                        .font(Font.system(size: 12))
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
                Spacer()
                Image(systemName: "bubble.left")
                Text("comment".localized)
                    .font(Font.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
    }
}

