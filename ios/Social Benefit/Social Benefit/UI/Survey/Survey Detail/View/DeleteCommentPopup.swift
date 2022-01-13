//
//  DeleteCommentPopup.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import SwiftUI

struct DeleteCommentPopup: ViewModifier {
    
    @Binding var comment: CommentResultModel?
    
    var action: (() -> Void)
    
    init(_ comment: Binding<CommentResultModel?>, action: @escaping (() -> Void)) {
        _comment = comment
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if comment != nil {
                VStack {
                    VStack(alignment: .leading) {
                        Text("delete_comment".localized)
                            .font(.system(size: 23))
                            .padding(.bottom, 5)
                        Text("are_you_sure_to_delete_comment".localized)
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                comment = nil
                            } label: {
                                Text("cancle".localized.uppercased())
                            }.padding(.leading, 100)
                            
                            Spacer()
                            
                            Button {
                                action()
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
                    comment = nil
                }
            }
        }
    }
}

extension View {
    
    func commentDeletePopup(_ comment: Binding<CommentResultModel?>, action: @escaping (() -> Void)) -> some View {
        return modifier(DeleteCommentPopup(comment, action: action))
    }
}
