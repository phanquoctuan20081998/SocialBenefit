//
//  ErrorMessageView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 21/09/2021.
//

import SwiftUI

struct PopUpMessageView: View {
    var text: String
    @Binding var isPresent: Bool
    
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {
                isPresent = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(textColor)
            })
            
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 15))
        }
        .padding()
        //        .frame(width: ScreenInfor().screenWidth * 0.8)
        .background(RoundedRectangle(cornerRadius: 25).fill(backgroundColor))
        .padding(.horizontal)
        .offset(x: 0, y: ScreenInfor().screenHeight * 0.3)
    }
}

struct ErrorMessageView: View {
    var error: String
    @Binding var isPresentedError: Bool
    
    var body: some View {
        if isPresentedError {
            PopUpMessageView(text: getError(errorCode: error), isPresent: $isPresentedError, textColor: Color.white, backgroundColor: Color.red)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isPresentedError = false
                    }
                }
        }
    }
}

struct SuccessedMessageView: View {
    var successedMessage: String
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            PopUpMessageView(text: successedMessage, isPresent: $isPresented, textColor: Color.white, backgroundColor: Color.black.opacity(0.7))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isPresented = false
                    }
                }
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessedMessageView(successedMessage: "sbchdbcshdbfgdhbsjhbdshcbdhsbchsdbchhdsbfhbsdhfhdbhsbdchbsdhbcshdbcsbdchsbhcbhbshdbfhbsdhfbsdhfbsbfhsssdfssbc", isPresented: .constant(true))
    }
}
