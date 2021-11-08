//
//  LoginView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var monitor = NetworkMonitor()
    
    @ObservedObject var sessionTimeOut = SessionTimeOut.shared
    @State var reload = false
    
    var body: some View {
        
        if !loginViewModel.isLogin || sessionController.isExpried {
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
                
                ErrorMessageView(error: "can_connect_server", isPresentedError: $sessionTimeOut.isTimeOut)
                    .offset(y: 400)
                
                if loginViewModel.isPresentResetPasswordView {
                    ResetPasswordView()
                        .environmentObject(loginViewModel)
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
                
            }
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $monitor.isConnected, content: {
                return Alert(title: Text("No Internet Connection"), message: Text("Please enable Wifi or Celluar data"), dismissButton: .default(Text("Cancel")))
            })
//            .navigationBarHidden(true)

//        }
        } else {
            ZStack(alignment: .top) {
                HomeScreenView(selectedTab: "house")
                    .environmentObject(loginViewModel)
                
//                ErrorMessageView(error: "can_connect_server", isPresentedError: $sessionController.isFailConnectToServer)
//                    .offset(y: 400)
            }
            
        }
    }
}

extension LoginView {
    
    var TextFieldView: some View {
        VStack(spacing: 25) {
            
            // Company Code textfield
            TextField("company".localized, text: $loginViewModel.companyCode)
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus1 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus1 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
                .onTapGesture {
                    loginViewModel.resetState()
                    loginViewModel.isFocus1 = true
                }
            
            
            // Company Code textfield
            TextField("email".localized,
                      text: $loginViewModel.employeeId)
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus2 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus2 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
                .onTapGesture {
                    loginViewModel.resetState()
                    loginViewModel.isFocus2 = true
                }
            
            
            // Company Code textfield
            SecureField("password".localized,
                      text: $loginViewModel.password)
                .font(.system(size: 15))
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(loginViewModel.isFocus3 ? Color.blue : Color.gray,
                                lineWidth: loginViewModel.isFocus3 ? 3 : 1))
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 30)
                .onTapGesture {
                    loginViewModel.resetState()
                    loginViewModel.isFocus3 = true
                }
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
                    sessionController.isExpried = false
                    
                    
                    
                    
                    print(loginViewModel.companyCode)
                    print(loginViewModel.isLogin)
                    
                    // If cannot login
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.MAX_API_LOAD_SECOND) {
                        if loginViewModel.isLoading {
//                            loginViewModel.isPresentCannotConnectServerError.toggle()
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
        
        //        Text("forgot_password".localized)
        //            .font(.system(size: 15))
        //            .sheet(isPresented: $loginViewModel.isPresentResetPasswordView, content: {
        //                ResetPasswordView()
        //            })
        //            .onTapGesture {
        //                loginViewModel.isPresentResetPasswordView.toggle()
        //            }
        
        Text("forgot_password".localized)
            .font(.system(size: 15))
            .foregroundColor(.blue)
            .onTapGesture {
                loginViewModel.isPresentResetPasswordView.toggle()
                loginViewModel.resetState()
            }
//            .background (
//                NavigationLink(
//                    destination: ResetPasswordView().navigationBarHidden(true),
//                    isActive: $loginViewModel.isPresentResetPasswordView,
//                    label: {
//                        EmptyView()
//                    }))
        
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
