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
    
    var contentId: Int
    var companyData: RecognitionData
    
    init(companyData: RecognitionData, contentId: Int) {
        self.companyData = companyData
        self.contentId = contentId
        self.reactViewModel = ReactViewModel(myReact: companyData.getMyReact(), reactTop1: companyData.getReactTop1(), reactTop2: companyData.getReactTop2())
    }
    
    var body: some View {
        VStack {
            ContentView
            LikeAndCommentCountBarView(numOfComment: companyData.getCommentCount(), contentType: Constants.ReactContentType.RECOGNIZE, totalOtherReact: companyData.getTotalOtherReact())
            Rectangle()
                .foregroundColor(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth * 0.8, height:  1)
            
            LikeAndCommentButton(contentId: contentId, contentType: Constants.ReactContentType.RECOGNIZE)
            
        }
        
        .environmentObject(reactViewModel)
        .font(.system(size: 14))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
        .frame(width: ScreenInfor().screenWidth * 0.93, height: 150, alignment: .bottom)
        .padding()
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
        }.padding()
    }
}


struct RecognitionNewsCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionNewsCardView(companyData: RecognitionData.sampleData[0], contentId: 8)
    }
}
