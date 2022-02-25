//
//  LoginViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var companyCode = ""
    @Published var employeeId = ""
    @Published var password = ""
    
    @Published var isRemember = false
    
    @Published var isLoading = false
    
    @Published var isPresentResetPasswordView: Bool = false
    
    private let loginService = LoginService()
    
    @Published var error: AppError = .none
    
    @Published var isAutoLogin = false
    
    init() {
        loadSaveData()
    }
    
    private func loadSaveData() {
        isRemember = UserDefaults.getLoginRemember()
        if isRemember {
            companyCode = UserDefaults.getCompanyCode()
            employeeId = UserDefaults.getEmployeeId()
            password = UserDefaults.getPassword()            
            isAutoLogin = UserDefaults.getAutoLogin()
            if isAutoLogin, validate() {
                login()
            }
        }
    }
    
    private func saveData() {
        if isRemember {
            UserDefaults.setCompanyCode(value: companyCode)
            UserDefaults.setEmployeeId(value: employeeId)
            UserDefaults.setPassword(value: password)
            UserDefaults.setAutoLogin(value: true)
        } else {
            UserDefaults.setCompanyCode(value: "")
            UserDefaults.setEmployeeId(value: "")
            UserDefaults.setPassword(value: "")
        }
        UserDefaults.setLoginRemember(value: isRemember)
        
    }
    
    func login() {
        clearError()
        if validate() {
            self.isLoading = true
            loginService.getAPI(companyCode: companyCode, userLogin: employeeId, password: password) { data in
                self.isLoading = false
                switch data {
                case .success(let value):
                    self.saveData()
                    updateUserInfor(model: value)
                    Utils.setTabbarIsRoot()
                case .failure(let error):
                    self.error = error
                    self.isAutoLogin = false
                }
            }
        } else {
            error = AppError.custom(text: "need_fill_all_data".localized)
        }
    }
    
    func validate() -> Bool {
        if employeeId.isEmpty || companyCode.isEmpty || password.isEmpty {
            return false
        }
        return true
    }
    
    func clearError() {
        error = .none
    }
    
}
