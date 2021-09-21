//
//  ErrorMessageView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 21/09/2021.
//

import SwiftUI

struct ErrorMessageView: View {
    var error: String
    @Binding var isPresentedError: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {
                isPresentedError = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            })
            
            Text(getError(errorCode: error))
                .foregroundColor(.white)
                .font(.system(size: 15))
            
            Spacer()
        }.padding()
        .frame(width: ScreenInfor().screenWidth * 0.8)
        .background(RoundedRectangle(cornerRadius: 25).fill(Color.red))
        .offset(x: 0, y: ScreenInfor().screenHeight * 0.3)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isPresentedError = false
            }
        }
    }
    
    func getError(errorCode: String) -> String {
        switch errorCode {
        case "M00136_E":
            return "buy_over_error".localized
        case "M00137_E":
            return "not_enough_voucher_error".localized
        default:
            return ""
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(error: "sbchdbcshdbfgsssdfssbc", isPresentedError: .constant(true))
    }
}
