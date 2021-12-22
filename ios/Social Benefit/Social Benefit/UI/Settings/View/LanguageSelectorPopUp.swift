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
    @State var curDragOffsetY: CGFloat = 0
    
    var body: some View {
        
        DragPopUp(curDragOffsetY: curDragOffsetY, isPresent: $isPresentedPopup, contentView: AnyView(PopUpContent))
    }
}

extension LanguageSelectorPopUp {
    
    var PopUpContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(Constants.LANGUAGE_TAB.indices) { i in
                Text(Constants.LANGUAGE_TAB[i].localized)
                    .onTapGesture {
                        withAnimation {
                            settingsViewModel.selectedlanguage = i
                            
                            switch settingsViewModel.selectedlanguage {
                            case 0: Bundle.setLanguage(lang: AppLanguage.en)
                            case 1: Bundle.setLanguage(lang: AppLanguage.vn)
                            default: Bundle.setLanguage(lang: AppLanguage.en)
                            }
//                            Bundle.setLanguage(lang: Constants.LANGUAGE_TAB[i])
                            UserDefaults.standard.set(i, forKey: "language")
                            isPresentedPopup = false
                        }
                    }
            }
        }.font(.system(size: 15))
            .padding(.horizontal, 20)
            .frame(width: ScreenInfor().screenWidth, height: 200)
            .background(
                RoundedCornersShape(radius: 40, corners: [.topLeft, .topRight])
                    .fill(Color.white)
            )
            .background(Rectangle()
                            .edgesIgnoringSafeArea(.bottom)
                            .offset(y: 50)
                            .foregroundColor(.white))
            .animation(.easeInOut)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

struct LanguageSelectorPopUp_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectorPopUp(isPresentedPopup: .constant(true))
    }
}
