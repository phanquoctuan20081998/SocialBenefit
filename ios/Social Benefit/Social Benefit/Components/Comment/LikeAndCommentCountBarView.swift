//
//  LikeAndCOmmentCountBarView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/11/2021.
//

import Foundation
import SwiftUI

struct LikeAndCommentCountBarView: View {
    
    @EnvironmentObject var reactViewModel: ReactViewModel
    
    var numOfComment: Int
    var contentType: Int = Constants.ReactContentType.INTERNAL_NEWS
    var totalOtherReact: Int = 0
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                let reactCount = reactViewModel.getTop2React().count
                
                // If there no react
                if reactCount == 0 {
                    EmptyView()
                    
                    // If it have some react
                } else {
                    HStack {
                        HStack(spacing: 4) {
                            if reactCount > 0 {
                                Image(reactViewModel.getTop2React()[0])
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                            if reactCount > 1 {
                                Image(reactViewModel.getTop2React()[1])
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                            if reactCount > 2 {
                                Image(reactViewModel.getTop2React()[2])
                                    .resizable()
                                    .frame(width: 15, height: 15)
                            }
                        }.scaledToFit()
                        
                        if contentType == Constants.ReactContentType.INTERNAL_NEWS {
                            if self.reactViewModel.isLike {
                                Text(self.reactViewModel.numOfReact == 1 ? "you".localized : "you_and %d".localizeWithFormat(arguments: self.reactViewModel.numOfReact - 1))
                                    .font(.system(size: 12))
                                    .bold()
                            } else {
                                Text(self.reactViewModel.numOfReact == 1 ? "%d other".localizeWithFormat(arguments: self.reactViewModel.numOfReact) : "%d others".localizeWithFormat(arguments: self.reactViewModel.numOfReact))
                                    .font(.system(size: 12))
                                    .bold()
                            }
                        } else if contentType == Constants.ReactContentType.RECOGNIZE {
                            if reactViewModel.selectedReaction != 6 {
                                if totalOtherReact == 0 {
                                    Text("you".localized)
                                        .font(.system(size: 12))
                                        .bold()
                                } else {
                                    Text("\("you".localized) \("and".localized) \(totalOtherReact) \("other people".localized)")
                                        .font(.system(size: 12))
                                        .bold()
                                }
                            } else {
                                if totalOtherReact != 0 {
                                    Text("\(totalOtherReact) \("other people".localized)")
                                        .font(.system(size: 12))
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            if numOfComment == 0 {
                Text("no_comment".localized)
                    .font(.system(size: 12))
                    .bold()
            } else if numOfComment == 1 {
                Text("\(numOfComment)" + " " + "count_comment".localized)
                    .font(.system(size: 12))
                    .bold()
            } else {
                Text("\(numOfComment)" + " " + "count_comments".localized)
                    .font(.system(size: 12))
                    .bold()
            }
        }
    }
}
