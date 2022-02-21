//
//  ResetPasswordView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var resetPasswordViewModel = ResetPasswordViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    Image("pic_background")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                
                VStack(spacing: 20) {
                    
                    Spacer().frame(height: ScreenInfor().screenHeight * 0.25)
                    
                    VStack(spacing: 20) {
                        
                        TitleView
                        
                        Spacer().frame(height: 20)
                        
                        TextFieldView
                        ResetPasswordButton
                        
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: ScreenInfor().screenWidth * 0.9, height: 2)
                        
                        BackToLogin
                        Spacer()
                        
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        
                        NavigationLink(destination: NavigationLazyView(ResetSuccessView()), isActive: $resetPasswordViewModel.isReseting) {
                            EmptyView()
                        }
                    }
                }
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                
                ErrorMessageView(error: "wrong_email_format".localized, isPresentedError: $resetPasswordViewModel.isPresentWrongFormatEmail)
                    .offset(y: 400)
                
                ErrorMessageView(error: "wrong_email".localized, isPresentedError: $resetPasswordViewModel.isPresentNotExistEmail)
                    .offset(y: 400)
                
                ErrorMessageView(error: "need_to_fill_all_data".localized, isPresentedError: $resetPasswordViewModel.isPresentAllTypedError)
                    .offset(y: 400)
                
                ErrorMessageView(error: "can_connect_server".localized, isPresentedError: $resetPasswordViewModel.isPresentCannotConnectServerError)
                    .offset(y: 400)
                
                ErrorMessageView(error: "wrong_company".localized, isPresentedError: $resetPasswordViewModel.isPresentNotExistCompany)
                    .offset(y: 400)
                
                if resetPasswordViewModel.isLoading {
                    VStack{
                        Spacer()
                        ActivityRep()
                        Spacer()
                    }
                    .background(Color.black.opacity(0.2)
                    .frame(width: ScreenInfor().screenWidth + 100, height: ScreenInfor().screenHeight + 100)
                    .edgesIgnoringSafeArea(.all))
                }
            }.edgesIgnoringSafeArea(.all)
            .onAppear {
                resetPasswordViewModel.resetTextField()
            }
            .onTapGesture {
                Utils.dismissKeyboard()
            }
        }
    }
}

extension ResetPasswordView {
    
    var TitleView: some View {
        VStack(spacing: 20) {
            Text("forgot_password".localized + "?")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(Color.blue)
            
            Text("infor".localized)
                .multilineTextAlignment(.center)
                .frame(width: ScreenInfor().screenWidth * 0.9)
                .font(.system(size: 15))
        }
    }
    
    var TextFieldView: some View {
        
        VStack(spacing: 30) {
            // Company Code textfield
            TextField("company".localized,
                      text: $resetPasswordViewModel.companyCode,
                      onEditingChanged: { (focus) in
                resetPasswordViewModel.isFocus1 = focus })
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(resetPasswordViewModel.isFocus1 ? Color.blue : Color.gray,
                                lineWidth: resetPasswordViewModel.isFocus1 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
            
            // Company Code textfield
            TextField("enter_email".localized,
                      text: $resetPasswordViewModel.email,
                      onEditingChanged: { (focus) in
                resetPasswordViewModel.isFocus2 = focus })
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(resetPasswordViewModel.isFocus2 ? Color.blue : Color.gray,
                                lineWidth: resetPasswordViewModel.isFocus2 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
        }
    }
    
    var ResetPasswordButton: some View {
        Button {
            if !resetPasswordViewModel.isAllTextAreTyped {
                resetPasswordViewModel.isPresentAllTypedError = true
            } else if !textFieldValidatorEmail(resetPasswordViewModel.email) {
                resetPasswordViewModel.isPresentWrongFormatEmail = true
            } else {
                resetPasswordViewModel.resetPasswordRequest()
                
                // If cannot connect to server
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.MAX_API_LOAD_SECOND) {
                    if resetPasswordViewModel.isLoading {
                        resetPasswordViewModel.isPresentCannotConnectServerError.toggle()
                        resetPasswordViewModel.isLoading = false
                    }
                }
            }
            
            Utils.dismissKeyboard()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 40)
                .overlay(
                    Text("reset_password".localized)
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                )
            
            
        }
    }
    
    var BackToLogin: some View {
        
        Button(action: {
            self.loginViewModel.isPresentResetPasswordView = false
        }, label: {
            Text("back_login".localized)
                .font(.system(size: 15))
                .italic()
        })
        
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
