//
//  AppInformationPopUp.swift
//  Social Benefit
//
//  Created by Admin on 9/30/21.
//

import SwiftUI

struct AppInformationPopUp: View {
    
    @Binding var isPresentedPopup: Bool
    var companyName: String
    var companyAddress: String
    
    var body: some View {
        PopUpView(isPresentedPopUp: $isPresentedPopup, outOfPopUpAreaTapped: outOfPopUpAreaTapped, popUpContent: AnyView(PopUpContentView))
    }
}


extension AppInformationPopUp {
    
    var PopUpContentView: some View {
        VStack {
            VStack {
                Text("social_benefits".localized)
                Text("version".localized + ": ")
                //                    Text("developed_by %s".localizeWithFormat(arguments: companyName))
                Text("\(companyAddress)")
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isPresentedPopup = false
                }
            }, label: {
                Text("Close")
                    .foregroundColor(.black)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                                    .frame(width: 80))
            })
            
            
        }.font(.system(size: 13))
        .padding(.vertical, 20)
        .frame(width: ScreenInfor().screenWidth * 0.7, height: 260)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white))
        .animation(.easeInOut)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
    
    func outOfPopUpAreaTapped() {
        withAnimation {
            isPresentedPopup = false
        }
    }
}
