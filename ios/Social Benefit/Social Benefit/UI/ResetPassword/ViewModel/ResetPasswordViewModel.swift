//
//  ResetPasswordViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import Foundation
import Combine
import SwiftUI

class ResetPasswordViewModel: ObservableObject {
    @Published var companyCode = ""
    @Published var email = ""
    
    @Published var isAllTextAreTyped = false
    @Published var isAllTextAreBlank = true
    
    @Published var isFocus1 = false
    @Published var isFocus2 = false
    
    @Published var isPresentWrongFormatEmail = false
    @Published var isPresentNotExistEmail = false
    @Published var isPresentAllTypedError = false
    @Published var isPresentCannotConnectServerError = false
    
    @Published var isLoading = false
    @Published var isReseting = false
    
    private var cancellables = Set<AnyCancellable>()
    private var resetPasswordService = ResetPasswordService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $companyCode
            .sink(receiveValue: reloadCompanyCode(companyCode:))
            .store(in: &cancellables)
        $email
            .sink(receiveValue: reloadEmail(email:))
            .store(in: &cancellables)
    }
    
    func reloadCompanyCode(companyCode: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !email.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && email.isEmpty
    }
    
    func reloadEmail(email: String) {
        self.isAllTextAreTyped = !companyCode.isEmpty && !email.isEmpty
        self.isAllTextAreBlank = companyCode.isEmpty && email.isEmpty
    }
    
    func resetPasswordRequest() {
        self.isLoading = true
        resetPasswordService.getAPI(companyCode: companyCode, email: email) { data in
            
            DispatchQueue.main.async {
                if data { self.isReseting = true }
                else { self.isPresentNotExistEmail = true }
                
                self.isLoading = false
            }
        }
    }
    
    func resetTextField() {
        self.companyCode = ""
        self.email = ""
    }
}
