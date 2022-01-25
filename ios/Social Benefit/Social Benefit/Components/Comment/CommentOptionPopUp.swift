//
//  CommentOptionPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/01/2022.
//

import SwiftUI

struct CommentOptionPopUp: View {
    
    @Binding var isPresent: Bool
    @Binding var text: String
    
    @State var isEditing: Bool = false
    @State var isDeleteConfirm: Bool = false
    
    var commentId: Int = -1
    var contentId: Int = -1
    var contentType: Int = Constants.CommentContentType.COMMENT_TYPE_COMMENT
    var parentId: Int = -1
    
    var body: some View {
        if isPresent {
            ZStack {
                Color.black.opacity(0.4)
                    .onTapGesture {
                        isPresent = false
                        isEditing = false
                        isDeleteConfirm = false
                    }
                if isEditing {
                    EditView
                } else if isDeleteConfirm {
                    ConfirmPopUp
                } else {
                    OptionView
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

extension CommentOptionPopUp {
    
    var OptionView: some View {
        VStack(alignment: .leading) {
            OptionCardView(image: "square.and.pencil", title: "edit_comment".localized, color: Color.blue)
                .onTapGesture {
                    self.isEditing = true
                }
            
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(width: ScreenInfor().screenWidth * 0.7, height: 1)
                .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
            
            OptionCardView(image: "xmark.bin.fill", title: "delete_comment".localized, color: Color.purple)
                .onTapGesture {
                    self.isDeleteConfirm = true
                }
        }
        .frame(width: ScreenInfor().screenWidth * 0.8, height: 130, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
    }
    
    var EditView: some View {
        HStack {

            AutoResizeTextField(text: $text, isFocus: .constant(true), minHeight: 30, maxHeight: 100, placeholder: "")
            
            Button {
                UpdateCommentService().getAPI(id: commentId, contentId: contentId, contentType: contentType, parentId: parentId, content: text) { id in
                    if id != -1 {
                        DispatchQueue.main.async {
                            self.isEditing = false
                            self.isPresent = false
                        }
                    }
                }
            } label: {
                Image(systemName: "paperplane.circle.fill")
                    .font(.system(size: 25))
            }
            .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0)
        }
        .padding()
        .frame(width: ScreenInfor().screenWidth * 0.8)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .offset(y: -100)
    }
    
    var ConfirmPopUp: some View {
        VStack(alignment: .leading) {
            Text("delete_comment".localized)
                .font(.system(size: 23))
                .padding(.bottom, 5)
            Text("are_you_sure_to_delete_comment".localized)
            
            Spacer()
            
            HStack {
                Button {
                    DispatchQueue.main.async {
                        self.isDeleteConfirm = false
                        self.isPresent = false
                    }
                } label: {
                    Text("cancel".localized.uppercased())
                }.padding(.leading, 100)
                
                Spacer()
                
                Button {
                    DeleteCommentService().getAPI(id: commentId, contentId: contentId, contentType: contentType, parentId: parentId, content: text) { id in
                        if id != -1 {
                            DispatchQueue.main.async {
                                self.isDeleteConfirm = false
                                self.isPresent = false
                            }
                        }
                    }
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
    
    @ViewBuilder
    func OptionCardView(image: String, title: String, color: Color) -> some View {
        HStack(spacing: 30) {
            Image(systemName: image)
                .foregroundColor(color)
                .frame(width: ScreenInfor().screenWidth * 0.1)
            
            Text(title)
            
            Spacer()
        }
        .font(.system(size: 17))
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .contentShape(Rectangle())
//        .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
    }
}


struct CommentOptionPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CommentOptionPopUp(isPresent: .constant(true), text: .constant("Tuan"))
    }
}
