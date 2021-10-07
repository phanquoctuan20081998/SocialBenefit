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
                        Text("confirm_message".localized)
                    }.font(.system(size: 15))
                        .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))
                        .frame(width: ScreenInfor().screenWidth * 0.8, height: 80, alignment: .topLeading)
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        Button("cancel".localized.uppercased()) {
                            isPresentedPopUp = false
                        }
                        
                        Button("confirm".localized.uppercased()) {
                            isPresentedPopUp = false
                            isPresentedPreviousPopUp = false
                        }
                    }.padding(20)
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
