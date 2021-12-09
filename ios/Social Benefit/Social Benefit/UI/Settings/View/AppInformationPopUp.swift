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
            Image("app_icon")
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack(spacing: 5) {
                Text("social_benefits".localized)
                Text("version".localized + ": ")
                Text("\("developed_by".localized) \(companyName)")
                Text("\(companyAddress)")
            }
            .frame(width: ScreenInfor().screenWidth * 0.5)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isPresentedPopup = false
                }
            }, label: {
                Text("close".localized)
                    .foregroundColor(.black)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.4))
                                    .frame(width: 80))
            })
            
            
        }.font(.system(size: 13))
            .foregroundColor(.gray)
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

struct AppInformation_Previews: PreviewProvider {
    static var previews: some View {
        AppInformationPopUp(isPresentedPopup: .constant(true), companyName: "NISSHO ELECTRONICS VIETNAM", companyAddress: "324, Tây Sơn, Đống Đa, Hà Nội, Việt Nam")
    }
}

