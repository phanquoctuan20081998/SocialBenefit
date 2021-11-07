//
//  LoginViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var companyCode: String = UserDefaults.standard.bool(forKey: "isChecked") ? UserDefaults.standard.string(forKey: "companyCode") ?? "" : ""
    @Published var employeeId: String = UserDefaults.standard.bool(forKey: "isChecked") ? UserDefaults.standard.string(forKey: "employeeId") ?? "": ""
    @Published var password: String = UserDefaults.standard.bool(forKey: "isChecked") ? UserDefaults.standard.string(forKey: "password") ?? "" : ""
    
    @Published var currentLang = "en"
    @Published var isChecked = UserDefaults.standard.bool(forKey: "isChecked")
    @Published var isLogin = false
    
    @Published var isFocus1 = false
    @Published var isFocus2 = false
    @Published var isFocus3 = false
    
    @Published var isAllTextAreTyped = false
    @Published var isAllTextAreBlank = true
    
    @Published var isPresentAllTypedError = false
    @Published var isPresentWrongError = false
//    @Published var isPresentCannotConnectServerError = false
    
    @Published var isLoading = false
    @Published var currentLanguage = previousUserLoginInfor.language
    
    @Published var isPresentResetPasswordView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    var loginService = LoginService()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $companyCode
            .sink(receiveValue: reloadCompanyCode(companyCode:))
            .store(in: &cancellables)
        
        $employeeId
            .sink(receiveValue: reloadCompanyCode(companyCode:))
            .store(in: &cancellables)
        
        $password
            .sink(receiveValue: reloadPassword(password:))
            .store(in: &cancellables)
        
        $isFocus1
            .sink(receiveValue: reloadIsFocus(isFocus:))
            .store(in: &cancellables)
        
        $isFocus2
            .sink(receiveValue: reloadIsFocus(isFocus:))
            .store(in: &cancellables)
        
        $isChecked
            .sink(receiveValue: switchRemeber(isRemember:))
            .store(in: &cancellables)
    }
    
    func loadLoginData(){
        self.isLoading = true
        if UserDefaults.standard.bool(forKey: "isChecked") {
            UserDefaults.standard.set(companyCode, forKey: "companyCode")
            UserDefaults.standard.set(employeeId, forKey: "employeeId")
            UserDefaults.standard.set(password, forKey: "password")
        }
        
        loginService.getAPI(companyCode: companyCode, userLogin: employeeId, password: password) { data in
            
            if data.isEmpty {
                DispatchQueue.main.async {
                    self.isPresentWrongError = true
                    self.isLoading = false
                }
            } else {

                let token = data["token"]
                let employeeDto = data["employeeDto"]
                let citizen = employeeDto["citizen"]
                
                updateUserInfor(userId: self.employeeId, token: token.string!, employeeDto: employeeDto, citizen: citizen)
                
                DispatchQueue.main.async {
                    self.isLogin = true
                    self.isLoading = false
                }
            }
        }
    }
    
    func reloadCompanyCode(companyCode: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
        UserDefaults.standard.set(companyCode, forKey: "companyCode")
    }
    
    func reloadEmployeeId(employeeId: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
        UserDefaults.standard.set(employeeId, forKey: "employeeId")
    }
        
    func reloadPassword(password: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    func reloadIsFocus(isFocus: Bool) {
        if isFocus {
            self.isFocus3 = false
        }
    }
    
    func updateToRemember() {
        previousUserLoginInfor.companyCode = self.companyCode
        previousUserLoginInfor.employeeId = self.employeeId
        previousUserLoginInfor.password = self.password
    }
    
    
    func switchRemeber(isRemember: Bool) {
        if isRemember {
            UserDefaults.standard.set(companyCode, forKey: "companyCode")
            UserDefaults.standard.set(employeeId, forKey: "employeeId")
            UserDefaults.standard.set(password, forKey: "password")
        } else {
            UserDefaults.standard.set(companyCode, forKey: "")
            UserDefaults.standard.set(employeeId, forKey: "")
            UserDefaults.standard.set(password, forKey: "")
        }
        
        UserDefaults.standard.set(isRemember, forKey: "isChecked")
    }
    
    func resetState() {
        isFocus1 = false
        isFocus2 = false
        isFocus3 = false
        
        isPresentAllTypedError = false
        isPresentWrongError = false
//        isPresentCannotConnectServerError = false
    }
    
}
