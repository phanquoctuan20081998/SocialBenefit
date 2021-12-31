//
//  ChangePasswordPopUpView.swift
//  Social Benefit
//
//  Created by Admin on 9/30/21.
//

import SwiftUI

struct ChangePasswordPopUpView: View {
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Binding var isPresentedPopUp: Bool
    @State var isPresentComfirmPopUp = false
    
    var body: some View {
        PopUpView(isPresentedPopUp: $isPresentedPopUp, outOfPopUpAreaTapped: outOfPopUpAreaTapped, popUpContent: AnyView(PopUpContent))
            .overlay(ConfirmPopUp(isPresentedPopUp: $isPresentComfirmPopUp, isPresentedPreviousPopUp: $settingsViewModel.isPresentedChangePasswordPopUp, variable: $settingsViewModel.isShowError))
    }
}

extension ChangePasswordPopUpView {
    
    var PopUpContent: some View {
        VStack(spacing: 5) {
            Image(systemName: "key.fill")
                .foregroundColor(.purple)
                .font(.system(size: 30))
                .rotationEffect(.degrees(-90))
            
            VStack {
                if settingsViewModel.isShowError {
                    Text(settingsViewModel.errorMeg)
                        .foregroundColor(.red)
                        .frame(width: ScreenInfor().screenWidth * 0.7, height: 40)
                        .multilineTextAlignment(.center)
                }
            }.frame(height: 30)
            
            VStack(spacing: 15) {
                PasswordTextField(title: "old_password".localized, placeHolder: "enter_old_password".localized, text: $settingsViewModel.oldPassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
                PasswordTextField(title: "new_password".localized, placeHolder: "enter_new_password".localized, text: $settingsViewModel.newPassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
                PasswordTextField(title: "retype_password".localized, placeHolder: "retype_new_password".localized, text: $settingsViewModel.retypePassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
            }
            
            Spacer()
            
            HStack {
                
                // Update button...
                Button(action: {
                    settingsViewModel.updateButtontapped()
                    settingsViewModel.isShowError = false
                }, label: {
                    Text("update".localized)
                        .foregroundColor(settingsViewModel.isAllTextFieldAreTyped ? .black : .gray)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(#colorLiteral(red: 0.6876488924, green: 0.7895539403, blue: 0.9556769729, alpha: 1)))
                                        .frame(width: 80))
                }).disabled(!settingsViewModel.isAllTextFieldAreTyped)
                
                Spacer().frame(width: 80)
                
                
                //Cancel button...
                Button(action: {
                    withAnimation {
                        if settingsViewModel.isAllTextFiledAreBlank {
                            isPresentedPopUp = false
                            settingsViewModel.isShowError = false
                        } else {
                            isPresentComfirmPopUp = true
                        }
                    }
                }, label: {
                    Text("cancel".localized)
                        .foregroundColor(.black)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                                        .frame(width: 80))
                })
            }
            
        }.font(.system(size: 13))
            .padding(.vertical, 25)
            .frame(width: ScreenInfor().screenWidth * 0.9, height: 400)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white))
            .animation(.easeInOut)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
    
    func outOfPopUpAreaTapped() {
        if settingsViewModel.isAllTextFiledAreBlank {
            withAnimation {
                isPresentedPopUp = false
                settingsViewModel.isShowError = false
            }
        } else {
            isPresentComfirmPopUp = true
        }
    }
    
    @ViewBuilder
    func PasswordTextField(title: String, placeHolder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            SecureField(placeHolder, text: text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
        }.padding(.horizontal, 20)
    }
}


struct ChangePasswordPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        //        ChangePasswordPopUpView(isPresentedPopUp: .constant(true))
        //            .environmentObject(SettingsViewModel())
        
        SettingsView()
    }
}
