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
                .foregroundColor(textColor)
                .font(.system(size: 15))
        }
        .padding()
//        .frame(width: ScreenInfor().screenWidth * 0.8)
        .background(RoundedRectangle(cornerRadius: 25).fill(backgroundColor))
        .padding(.horizontal, 30)
        .offset(x: 0, y: ScreenInfor().screenHeight * 0.3)
    }
}

let PopUpTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

struct ErrorMessageView: View {
    var error: String
    @Binding var isPresentedError: Bool
    
    var body: some View {
        if isPresentedError {
            PopUpMessageView(text: error.localized, isPresent: $isPresentedError, textColor: Color.white, backgroundColor: Color.red)
                .onReceive(PopUpTimer) { _ in
                    isPresentedError = false
                }
        }
    }
}

struct SuccessedMessageView: View {
    var successedMessage: String
    var color: Color = Color.black.opacity(0.9)
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            PopUpMessageView(text: successedMessage, isPresent: $isPresented, textColor: Color.white, backgroundColor: color)
                .onReceive(PopUpTimer) { _ in
                    isPresented = false
                }
                
        }
    }
}

struct WhiteWarningMessageView: View {
    var message: String
    var color: Color = Color.white
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            PopUpMessageView(text: message.localized, isPresent: $isPresented, textColor: Color.black, backgroundColor: color)
                .onReceive(PopUpTimer) { _ in
                    isPresented = false
                }
        }
    }
}

struct WarningMessageView: View {
    var message: String
    var color: Color = Color.yellow
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            PopUpMessageView(text: message.localized, isPresent: $isPresented, textColor: Color.black, backgroundColor: color)
                .onReceive(PopUpTimer) { _ in
                    isPresented = false
                }
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessedMessageView(successedMessage: "Update", color: .green, isPresented: .constant(true))
    }
}
