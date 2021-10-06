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
            .overlay(ConfirmPopUp(isPresentedPopUp: $isPresentComfirmPopUp, isPresentedPreviousPopUp: $settingsViewModel.isPresentedChangePasswordPopUp))
    }
}

extension ChangePasswordPopUpView {
    
    var PopUpContent: some View {
        VStack {
            Image(systemName: "key.fill")
                .foregroundColor(.purple)
                .font(.system(size: 30))
                .rotationEffect(.degrees(-90))
            
            VStack {
                if settingsViewModel.isShowError {
                    Text(settingsViewModel.errorMeg)
                        .foregroundColor(.red)
                }
            }.frame(height: 20)
            
            VStack(spacing: 15) {
                PasswordTextField(title: "old_password".localized, placeHolder: "enter_old_password", text: $settingsViewModel.oldPassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
                PasswordTextField(title: "new_password".localized, placeHolder: "enter_new_password", text: $settingsViewModel.newPassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
                PasswordTextField(title: "retype_password".localized, placeHolder: "retype_new_password", text: $settingsViewModel.retypePassword)
                    .onTapGesture {
                        settingsViewModel.resetError()
                    }
            }
            
            Spacer()
            
            HStack {
                
                // Update button...
                Button(action: {
                    settingsViewModel.updateButtontapped()
                }, label: {
                    Text("Update".localized)
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

// Them ham common check password

struct ConfirmPopUp: View {
    
//    @EnvironmentObject var settingsViewModel: SettingsViewModel
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

struct ChangePasswordPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        //        ChangePasswordPopUpView(isPresentedPopUp: .constant(true))
        //            .environmentObject(SettingsViewModel())
        
        SettingsView()
    }
}
