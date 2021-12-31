//
//  ConfirmPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/10/2021.
//

import SwiftUI

struct ConfirmPopUp: View {
    
    @Binding var isPresentedPopUp: Bool
    @Binding var isPresentedPreviousPopUp: Bool
    
    @Binding var variable: Bool
    
    var body: some View {
        ZStack {
            if isPresentedPopUp {
                Color.black
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresentedPopUp = false
                    }
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text("warning".localized)
                            .bold()
                            .font(.system(size: 20))
                            .padding(.bottom, 1)
                        Text("confirm_message".localized)
                    }.font(.system(size: 15))
                        .padding(.init(top: 10, leading: 30, bottom: 0, trailing: 30))
                        .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .topLeading)
                    
                    HStack(spacing: 30) {
                        Button("cancel".localized.uppercased()) {
                            isPresentedPopUp = false
                        }
                        
                        Button("confirm".localized.uppercased()) {
                            isPresentedPopUp = false
                            isPresentedPreviousPopUp = false
                            variable.toggle()
                        }
                    }
                    .padding(.init(top: 2, leading: 20, bottom: 10, trailing: 30))
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .bottomTrailing)
                    .foregroundColor(.blue)
                    
                }.font(.system(size: 13))
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 130)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10))
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(.black)
    }
}

struct ConfirmPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPopUp(isPresentedPopUp: .constant(true), isPresentedPreviousPopUp: .constant(true), variable: .constant(true))
    }
}
