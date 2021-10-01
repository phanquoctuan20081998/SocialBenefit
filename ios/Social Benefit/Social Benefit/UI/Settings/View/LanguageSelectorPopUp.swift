//
//  LanguageSelectorPopUp.swift
//  Social Benefit
//
//  Created by Admin on 9/30/21.
//

import SwiftUI

struct LanguageSelectorPopUp: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Binding var isPresentedPopup: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresentedPopup = false
                        }
                    }
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(Constants.LANGUAGE_TAB.indices) { i in
                        Text(Constants.LANGUAGE_TAB[i].localized)
                            .onTapGesture {
                                withAnimation {
                                    settingsViewModel.selectedlanguage = i
                                    isPresentedPopup = false
                                }
                            }
                    }
                }.font(.system(size: 15))
                .padding(30)
                .frame(width: ScreenInfor().screenWidth, height: 260, alignment: .topLeading)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                )
                .animation(.easeInOut)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        .foregroundColor(.black)
    }
}

struct LanguageSelectorPopUp_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectorPopUp(isPresentedPopup: .constant(true))
    }
}
