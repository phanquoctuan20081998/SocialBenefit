//
//  LikeAndCommentButton.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/11/2021.
//

import SwiftUI

struct LikeAndCommentButton: View {
    
    @EnvironmentObject var reactViewModel: ReactViewModel
    //    @Binding var previousReaction: Int
    var contentId: Int
    var contentType: Int = Constants.ReactContentType.INTERNAL_NEWS
    
    var body: some View {
        ZStack {
            
            // Like Button
            HStack {
                HStack {
                    HStack {
                        if !self.reactViewModel.isLike {
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                Text("\((reactViewModel.getTop2React().count == 0) ? "be_the_first".localized : "like".localized)")
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
                                        .frame(width: 20,
                                               height: 20)
                                    Text(reactions[self.reactViewModel.selectedReaction].localized)
                                        .foregroundColor(reactionColors[self.reactViewModel.selectedReaction])
                                        .font(.system(size: 12))
                                }
                            }
                        }
                    }
                    
                    .onTapGesture {
                        if self.reactViewModel.isLike {
                            
                            //Update delete reaction on server
                            AddReactService().getAPI(contentId: contentId, contentType: contentType, reactType: self.reactViewModel.selectedReaction)
                            
                            self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] -= 1
                            self.reactViewModel.numOfReact -= 1
                            self.reactViewModel.selectedReaction = 6
                            
                        } else {
                            
                            self.reactViewModel.selectedReaction = 0
                            self.reactViewModel.reactCount[self.reactViewModel.selectedReaction] += 1
                            self.reactViewModel.numOfReact += 1
                            
                            //Update delete uncheck reaction on server
                            AddReactService().getAPI(contentId: contentId, contentType: contentType, reactType: self.reactViewModel.selectedReaction)
                            self.reactViewModel.previousReaction = self.reactViewModel.selectedReaction
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
            
            // Reaction Bar
            if reactViewModel.isShowReactionBar {
                ReactionBarView(isShowReactionBar: $reactViewModel.isShowReactionBar, selectedReaction: $reactViewModel.selectedReaction)
                    .offset(x: -30, y: 50)
                    .zIndex(2)
            }
        }
        .frame(height: 40)
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
                self.reactViewModel.reactCount[self.reactViewModel.previousReaction] -= 1
            }
            
            reactViewModel.isShowReactionBar = false
            reactViewModel.isLike = true
            
            //Update reaction on server
            AddReactService().getAPI(contentId: contentId, contentType: contentType, reactType: self.reactViewModel.selectedReaction)
            self.reactViewModel.previousReaction = self.reactViewModel.selectedReaction
        }
    }
}


