//
//  SettingsViewModel.swift
//  Social Benefit
//
//  Created by Admin on 9/30/21.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject, Identifiable {
    @Published var isAllowNotiSwitchOn: Bool = false
    @Published var isAllowSoundSwitchOn: Bool = false
    @Published var selectedlanguage = UserDefaults.standard.integer(forKey: "language")
    @Published var isPresentedChangePasswordPopUp = false
    @Published var isPresentedLanguagePopup = false
    @Published var isPresentedAppinformationPopUp = false
    
    // For Change password
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var retypePassword = ""
    @Published var isAllTextFieldAreTyped = false
    @Published var isAllTextFiledAreBlank = true
    @Published var isShowError = false
    @Published var errorMeg = ""
    
    private var changePasswordService = ChangePasswordService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $oldPassword
            .sink(receiveValue: loadOldPassword(oldPassword:))
            .store(in: &cancellables)
        
        $newPassword
            .sink(receiveValue: loadNewPassword(newPassword:))
            .store(in: &cancellables)
        
        $retypePassword
            .sink(receiveValue: loadRetypePassword(retypePassword:))
            .store(in: &cancellables)
    }
    
    func loadOldPassword(oldPassword: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !oldPassword.isEmpty && !self.newPassword.isEmpty && !self.retypePassword.isEmpty
            self.isAllTextFiledAreBlank = oldPassword.isEmpty && self.newPassword.isEmpty && self.retypePassword.isEmpty
        }
    }
    
    func loadNewPassword(newPassword: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !self.oldPassword.isEmpty && !newPassword.isEmpty && !self.retypePassword.isEmpty
            self.isAllTextFiledAreBlank = self.oldPassword.isEmpty && newPassword.isEmpty && self.retypePassword.isEmpty
        }
    }
    
    func loadRetypePassword(retypePassword: String) {
        DispatchQueue.main.async {
            self.isAllTextFieldAreTyped = !self.oldPassword.isEmpty && !self.newPassword.isEmpty && !retypePassword.isEmpty
            self.isAllTextFiledAreBlank = self.oldPassword.isEmpty && self.newPassword.isEmpty && retypePassword.isEmpty
        }
    }
    
    func resetPassword() {
        self.oldPassword = ""
        self.newPassword = ""
        self.retypePassword = ""
    }
    
    func updatePassword(returnCallBack: @escaping (Int) -> ()) {
        changePasswordService.getAPI(userId: userInfor.employeeId, oldPass: self.oldPassword, newPass: self.newPassword) { code in
            returnCallBack(code)
        }
    }
    
    func updateErrorMeg(errorMeg: String) {
        self.errorMeg = errorMeg
    }
    
    func updateButtontapped() {
        if self.newPassword != self.retypePassword {
            getError(Constants.ChangePasswordErrors.password_not_match.localized)
        } else if self.newPassword.count < 6 || self.newPassword.count > 15 {
            getError(Constants.ChangePasswordErrors.password_6_to_15.localized)
        } else if !self.isAllTextFieldAreTyped {
            getError(Constants.ChangePasswordErrors.need_to_fill_all_data.localized)
        } else {
            self.updatePassword { [self] code in
                if code == Constants.ChangePasswordErrorCodeResponse.MOBILE_WRONG_OLD_PASSWORD {
                    getError(Constants.ChangePasswordErrors.wrong_old_password)
                } else if code == Constants.ChangePasswordErrorCodeResponse.MOBILE_CHANGE_PASSWORD_OK {
                    DispatchQueue.main.async {
                        self.isShowError = false
                        self.isPresentedChangePasswordPopUp = false
                    }
                } else {
                    getError(Constants.ChangePasswordErrors.api_call_failed)
                }
            }
        }
    }
    
    func getError(_ error: String) {
        DispatchQueue.main.async {
            self.errorMeg = error
            self.isShowError = true
        }
    }
    
    func resetError() {
        self.isShowError = false
        self.errorMeg = ""
    }
}

