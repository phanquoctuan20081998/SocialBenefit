//
//  LoginView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import SwiftUI
import SwiftyJSON

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
                    
                    Spacer().frame(height: 70)
                    
                    TextFieldView
                    
                    Spacer().frame(height: 40)
                    
                    VStack {
                        CheckBoxView
                        LoginButton
                        ForgotPassword
                    }
                    
                    Spacer().frame(height: 40)
                    
                    VStack(spacing: 20) {
                        WarningText
                        ChangeLanguageButton
                    }
                }
                
                
                ErrorMessageView(error: "need_to_fill_all_data", isPresentedError: $loginViewModel.isPresentAllTypedError)
                    .offset(y: 400)
                
                ErrorMessageView(error: "wrong_data", isPresentedError: $loginViewModel.isPresentWrongError)
                    .offset(y: 400)
                
                NavigationLink(destination: HomeScreenView(selectedTab: "house").navigationBarHidden(true), isActive: $loginViewModel.isLogin) {
                    EmptyView()
                }
            }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

extension LoginView {
    
    var TextFieldView: some View {
        VStack(spacing: 40) {
            
            // Company Code textfield
            TextField("company".localized,
                      text: $loginViewModel.companyCode,
                      onEditingChanged: { (focus) in
                loginViewModel.isFocus1 = focus })
                .padding(10)
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
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus2 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus2 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
            
            // Company Code textfield
            TextField("password".localized,
                      text: $loginViewModel.password,
                      onEditingChanged: { (focus) in
                loginViewModel.isFocus3 = focus })
                .padding(10)
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
        }
    }
    
    var LoginButton: some View {
        VStack {
            Button {
                if loginViewModel.isAllTextAreTyped {
                    loginViewModel.loginService.getAPI(companyCode: loginViewModel.companyCode, userLogin: loginViewModel.employeeId, password: loginViewModel.password) { data in
                        
                        let token = data["token"]
                        let employeeDto = data["employeeDto"]
                        let citizen = employeeDto["citizen"]
                        
                        updateUserInfor(userId: loginViewModel.employeeId, token: token.string!, employeeDto: employeeDto, citizen: citizen)
                        
                        loginViewModel.isLogin = true
                    }
                    
                    // If cannot login
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if !loginViewModel.isLogin {
                            loginViewModel.isPresentWrongError.toggle()
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
            }
        }
    }
    
    var ForgotPassword: some View {
        NavigationLink {
            Text("1")
        } label: {
            Text("forgot_password".localized)
        }
        
    }
    
    var WarningText: some View {
        VStack {
            Text("warning1".localized)
            Text("warning2".localized)
        }
    }
    
    var ChangeLanguageButton: some View {
        HStack(spacing: 20) {
            Button {
                Bundle.setLanguage(lang: "vn")
                reload.toggle()
            } label: {
                Image("pic_language1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 15)
            }

            Button {
                Bundle.setLanguage(lang: "en")
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
