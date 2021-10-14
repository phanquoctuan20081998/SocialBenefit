//
//  LoginViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/10/2021.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var companyCode = ""
    @Published var employeeId = ""
    @Published var password = ""
    
    @Published var currentLang = "en"
    @Published var isChecked = false
    @Published var isLogin = false
    
    @Published var isFocus1 = false
    @Published var isFocus2 = false
    @Published var isFocus3 = false
    
    @Published var isAllTextAreTyped = false
    @Published var isAllTextAreBlank = true
    
    @Published var isPresentAllTypedError = false
    @Published var isPresentWrongError = false
    
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
        
    }
    
    func reloadCompanyCode(companyCode: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
    }
    
    func reloadEmployeeId(employeeId: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
    }
        
    func reloadPassword(password: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !employeeId.isEmpty && !password.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && employeeId.isEmpty && password.isEmpty
    }
}
