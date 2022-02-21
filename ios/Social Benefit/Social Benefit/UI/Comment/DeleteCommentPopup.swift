//
//  DeleteCommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct DeleteCommentPopup: View {
    
    @EnvironmentObject var commentEnvironment: CommentEnvironmentObject
    
    var body: some View {
        GeometryReader { geometry in
            if commentEnvironment.commentDeleted != nil {
                VStack {
                    VStack(alignment: .leading) {
                        Text("delete_comment".localized)
                            .font(.system(size: 23))
                            .padding(.bottom, 5)
                        Text("are_you_sure_to_delete_comment".localized)
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                commentEnvironment.commentDeleted = nil
                            } label: {
                                Text("cancel".localized.uppercased())
                            }.padding(.leading, 100)
                            
                            Spacer()
                            
                            Button {
                                commentEnvironment.deleteComment()
                            } label: {
                                Text("delete".localized.uppercased())
                            }

                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(.white))
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 180)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.black.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    commentEnvironment.commentDeleted = nil
                }
                .errorPopup($commentEnvironment.error)
                .loadingView(isLoading: $commentEnvironment.isLoading)
            }
        }
    }
}
