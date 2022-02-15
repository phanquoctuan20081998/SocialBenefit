//
//  SettingsView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/09/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    @ObservedObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
            
            Text("settings".localized.uppercased())
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.blue)
                

            VStack(alignment: .leading) {
                settingTitle(text: "security".localized)
                settingOption(image: "key.fill", color: Color.purple, title: "change_password".localized, trailingElement: "", switchOnVariable: .constant(false))
                Spacer().frame(height: 30)
            }.padding(.top, 20)
            .onTapGesture {

                settingsViewModel.resetPassword()
                settingsViewModel.isPresentedChangePasswordPopUp = true
                
            }
            
            VStack(alignment: .leading) {
                settingTitle(text: "select_language".localized)
                settingOption(image: "globe", color: Color.green, title: "current_language".localized, trailingElement: "selector", switchOnVariable: .constant(false))
                Spacer().frame(height: 30)
            }
            
            // Notification setting
            
//            VStack(alignment: .leading) {
//                settingTitle(text: "notification".localized)
//                settingOption(image: "bell.fill", color: Color.blue, title: "allow_popup_notification".localized, trailingElement: "switch", switchOnVariable: $settingsViewModel.isAllowNotiSwitchOn)
//                settingOption(image: "speaker.slash.fill", color: Color.red, title: "allow_sound_on_notification".localized, trailingElement: "switch", switchOnVariable: $settingsViewModel.isAllowSoundSwitchOn)
//                Spacer().frame(height: 30)
//            }
            
            VStack(alignment: .leading) {
                settingTitle(text: "other_setting".localized)
                settingOption(image: "info.circle.fill", color: Color.blue, title: "application_information".localized, trailingElement: "", switchOnVariable: .constant(false))
                Spacer().frame(height: 30)
            }.onTapGesture {
                settingsViewModel.isPresentedAppinformationPopUp = true
                
                // Click count
                countClick()
            }
            
            Spacer()
        }.background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreen.isPresentedTabBar, title: "", isHaveLogo: true))
        
        // Pop Up
        .overlay(LanguageSelectorPopUp(isPresentedPopup: $settingsViewModel.isPresentedLanguagePopup), alignment: .top)
        .overlay(AppInformationPopUp(isPresentedPopup: $settingsViewModel.isPresentedAppinformationPopUp, companyName: "NISSHO ELECTRONICS VIETNAM", companyAddress: "company_address".localized))
        .overlay(ChangePasswordPopUpView(isPresentedPopUp: $settingsViewModel.isPresentedChangePasswordPopUp)
        )
        .environmentObject(settingsViewModel)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func settingTitle(text: String) -> some View {
        Text(text)
            .bold()
            .padding()
    }
    
    func settingOption(image: String, color: Color, title: String, trailingElement: String, switchOnVariable: Binding<Bool>) -> some View {
        
        HStack {
            Image(systemName: image)
                .foregroundColor(color)
                .font(.system(size: 20))
                .frame(width: 30, height: 30)
                .if(image == "key.fill") { view in
                    view.rotationEffect(.degrees(-90))
                }
            Text(title)
                .padding(.leading, 5)
            Spacer()
            
            if trailingElement == "selector" {
                HStack {
                    Text(Constants.LANGUAGE_TAB[settingsViewModel.selectedlanguage].localized)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .frame(width: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1))
                .onTapGesture {
                    settingsViewModel.isPresentedLanguagePopup = true
                    
                    // Click count
                    countClick()
                }
            } else if trailingElement == "switch" {
                Toggle(isOn: switchOnVariable) {}
                    .frame(width: 65)
            } else {
                Spacer()
            }
        }.padding(.horizontal, 20)
        .font(.system(size: 13))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(HomeScreenViewModel())
    }
}
