//
//  LoginView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    @State var reload = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // This for reload page after changing language...
            if reload {
                EmptyView()
            }
            
            // Display background...
            VStack {
                Image("pic_background")
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            
            VStack(spacing: 10) {
                
                Spacer()
                    .frame(minHeight: 50, maxHeight: 100)
                
                URLImageView(url: userInfor.companyLogo)
                    .scaledToFit()
                    .frame(width: ScreenInfor().screenWidth * 0.7, height: 80)
                
                Spacer()
                
                TextFieldView
                
                Spacer()
                
                VStack {
                    CheckBoxView
                    LoginButton
                    ForgotPassword
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    WarningText
                    ChangeLanguageButton
                }
                Spacer()
            }
            
            if loginViewModel.isPresentResetPasswordView {
                ResetPasswordView()
                    .environmentObject(loginViewModel)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .loadingView(isLoading: $loginViewModel.isLoading)
        .errorPopup($loginViewModel.error)
        .background(Color.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension LoginView {
    
    var TextFieldView: some View {
        VStack(spacing: 10) {
            
            LoginTextField.init(text: $loginViewModel.companyCode, isSecure: false, placeholder: "company".localized)
            
            LoginTextField.init(text: $loginViewModel.employeeId, isSecure: false, placeholder: "email".localized)
            
            LoginTextField.init(text: $loginViewModel.password, isSecure: true, placeholder: "password".localized)
        }
    }
    
    var CheckBoxView: some View {
        HStack {
            CheckBox(checked: $loginViewModel.isRemember)
            Text("remember_me".localized)
                .font(.system(size: 15))
        }
    }
    
    var LoginButton: some View {
        VStack {
            Button {
                Utils.dismissKeyboard()
                loginViewModel.login()
            } label: {
                Text("login".localized)
                    .foregroundColor(.black)
                    .padding(.init(top: 10, leading: 50, bottom: 10, trailing: 50))
                    .background(
                        RoundedRectangle(cornerRadius: 10).fill(Color("nissho_light_blue"))
                    )
                    .font(.system(size: 15))
            }
        }
    }
    
    var ForgotPassword: some View {
        Text("forgot_password".localized)
            .font(.system(size: 15))
            .foregroundColor(.blue)
            .onTapGesture {
                loginViewModel.isPresentResetPasswordView.toggle()
                loginViewModel.clearError()
            }
    }
    
    var WarningText: some View {
        VStack {
            Text("warning1".localized)
            Text("warning2".localized)
        }.font(.system(size: 15))
    }
    
    var ChangeLanguageButton: some View {
        HStack(spacing: 20) {
            Button {
                Bundle.setLanguage(lang: AppLanguage.vi)
                reload.toggle()
                loginViewModel.clearError()
                UserDefaults.standard.set(1, forKey: "language")
            } label: {
                Image("pic_language1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 15)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button {
                Bundle.setLanguage(lang: AppLanguage.en)
                reload.toggle()
                loginViewModel.clearError()
                UserDefaults.standard.set(0, forKey: "language")
            } label: {
                Image("pic_language2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 15)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
