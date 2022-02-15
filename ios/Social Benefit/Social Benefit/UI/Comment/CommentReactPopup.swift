//
//  CommentReactPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 07/02/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CommentReactPopup: View {
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject
    
    var body: some View {
        if commentEnvironment.commentReacted != nil {
            VStack {
                if let position = commentEnvironment.commentPosition {
                    Spacer()
                        .frame(height: position.origin.y - 30)
                       
                }
                HStack {
                    Spacer()
                            .frame(width: 10)
                    HStack(spacing: 5) {
                        ForEach(ReactionType.allCases, id: \.self) { type in
                            if type != .none {
                                Button.init {
                                    commentEnvironment.addReactForComment(type)
                                    commentEnvironment.clearCommentReacted()
                                } label: {
                                    AnimatedImage(name: type.gif)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .aspectRatio(contentMode: .fit)
                                }
                                .background(type == commentEnvironment.commentReacted?.reactionType ? Color.gray.opacity(0.2) : Color.clear)
                                .cornerRadius(30)                                
                            }
                        }
                    }
                    .padding(10)
                    .background(Color.white.clipShape(Capsule()))
                    .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: 5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.black.opacity(0.001))
            .contentShape(Rectangle())
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                commentEnvironment.clearCommentReacted()
            }
            .onDisappear {
                commentEnvironment.clearCommentReacted()
            }
            .onAppear(perform: {
                Utils.dismissKeyboard()
            })
            .errorPopup($commentEnvironment.error)
        }
    }
}
