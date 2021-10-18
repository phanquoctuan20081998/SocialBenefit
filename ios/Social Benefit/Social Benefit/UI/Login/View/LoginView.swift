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
        NavigationView {
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
                
                VStack(spacing: 20) {
                    
                    Spacer().frame(height: 100)
                    
                    //URLImageView(url: userInfor.companyLogo)
                    Image("pic_company_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
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
                
                
                ErrorMessageView(error: "need_to_fill_all_data", isPresentedError: $loginViewModel.isPresentAllTypedError)
                    .offset(y: 400)
                
                ErrorMessageView(error: "wrong_data", isPresentedError: $loginViewModel.isPresentWrongError)
                    .offset(y: 400)
                
                ErrorMessageView(error: "can_connect_server", isPresentedError: $loginViewModel.isPresentCannotConnectServerError)
                    .offset(y: 400)
                
                if loginViewModel.isLogin {
                    NavigationLink(destination: HomeScreenView(selectedTab: "house").navigationBarHidden(true), isActive: $loginViewModel.isLogin) {
                        EmptyView()
                    }
                }
                
                if loginViewModel.isLoading {
                    VStack{
                        Spacer()
                        ActivityRep()
                        Spacer()
                    }
                    .background(Color.black.opacity(0.2)
                    .frame(width: ScreenInfor().screenWidth, height: ScreenInfor().screenHeight)
                    .edgesIgnoringSafeArea(.all))
                }
                
            }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

extension LoginView {
    
    var TextFieldView: some View {
        VStack(spacing: 25) {
            
            // Company Code textfield
            TextField("company".localized,
                      text: $loginViewModel.companyCode,
                      onEditingChanged: { (focus) in
                loginViewModel.isFocus1 = focus })
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus1 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus1 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
            
            // Company Code textfield
            TextField("email".localized,
                      text: $loginViewModel.employeeId,
                      onEditingChanged: { (focus) in
                loginViewModel.isFocus2 = focus })
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus2 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus2 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
            
            // Company Code textfield
            SecureField("password".localized,
                      text: $loginViewModel.password)
                .onTapGesture {
                    loginViewModel.isFocus3 = true
                }
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus3 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus3 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
        }
    }
    
    var CheckBoxView: some View {
        HStack {
            CheckBox(checked: $loginViewModel.isChecked)
            Text("remember_me".localized)
                .font(.system(size: 15))
        }
    }
    
    var LoginButton: some View {
        VStack {
            Button {
                if loginViewModel.isAllTextAreTyped {
                    
                    loginViewModel.updateToRemember()
                    loginViewModel.loadLoginData()
                    
                    // If cannot login
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        if loginViewModel.isLoading {
                            loginViewModel.isPresentCannotConnectServerError.toggle()
                            loginViewModel.isLoading = false
                        }
                    }
                    
                } else {
                    // If textfiled are blank
                    loginViewModel.isPresentAllTypedError.toggle()
                }
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
        NavigationLink {
            ResetPasswordView().navigationBarHidden(true)
        } label: {
            Text("forgot_password".localized)
                .font(.system(size: 15))
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
                Bundle.setLanguage(lang: "vn")
                UserDefaults.standard.set(Constants.LANGUAGE.VN, forKey: "language")
                reload.toggle()
            } label: {
                Image("pic_language1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 15)
            }

            Button {
                Bundle.setLanguage(lang: "en")
                UserDefaults.standard.set(Constants.LANGUAGE.ENG, forKey: "language")
                reload.toggle()
            } label: {
                Image("pic_language2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 15)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() 
    }
}
