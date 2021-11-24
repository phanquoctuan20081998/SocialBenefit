//
//  RecognitionNewsCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import SwiftUI

struct RecognitionNewsCardView: View {
    
    @ObservedObject var reactViewModel: ReactViewModel
    @State var previousReaction: Int = 6 // index = 6 is defined as "" in reaction array
    
    @Binding var commentText: String
    @Binding var commentCount: Int
    
    var contentId: Int
    var companyData: RecognitionData
    
    init(companyData: RecognitionData, contentId: Int, commentText: Binding<String>, commentCount: Binding<Int>) {
        self.companyData = companyData
        self.contentId = contentId
        self.reactViewModel = ReactViewModel(myReact: companyData.getMyReact(), reactTop1: companyData.getReactTop1(), reactTop2: companyData.getReactTop2())
        
        _commentText = commentText
        _commentCount = commentCount
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ContentView
            LikeAndCommentCountBarView(numOfComment: companyData.getCommentCount(), contentType: Constants.ReactContentType.RECOGNIZE, totalOtherReact: companyData.getTotalOtherReact())
            Rectangle()
                .foregroundColor(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth * 0.8, height:  1)
            
            LikeAndCommentButton(contentId: contentId, contentType: Constants.ReactContentType.RECOGNIZE)
                .frame(height: 10)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
            
            CommentBarView(isReply: .constant(false), replyTo: .constant(""), parentId: .constant(-1), commentText: $commentText, SendButtonView: AnyView(SendCommentButtonView))
        }
        .environmentObject(reactViewModel)
        .padding()
        .font(.system(size: 14))
        
        .frame(width: ScreenInfor().screenWidth * 0.93, alignment: .bottom)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        
    }
}

extension RecognitionNewsCardView {
    
    var ContentView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(companyData.getTime()) \(companyData.getDate())")
                
                Spacer()
                
                Text("+\(companyData.getPoint())")
                    .bold()
                    .foregroundColor(.blue)
            }
            
            Text("**\(companyData.getFrom())** \("to".localized) **\(companyData.getTo())**")
            
            Text(companyData.getMessage())
                .italic()
        }
    }
    
    var SendCommentButtonView: some View {
        Button(action: {
            AddCommentService().getAPI(contentId: contentId, parentId: -1, content: commentText, returnCallBack: { newCommentId in
                DispatchQueue.main.async {
                    self.commentText = ""
                    self.commentCount += 1
                }
            })
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
        RecognitionNewsCardView(companyData: RecognitionData.sampleData[0], contentId: 8, commentText: .constant(""), commentCount: .constant(0))
    }
}
