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
    @Published var selectedlanguage = Constants.LANGUAGE.ENG
    @Published var isPresentedChangePasswordPopUp = false
    @Published var isPresentedLanguagePopup = false
    @Published var isPresentedAppinformationPopUp = false
    
    // For Change password
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var retypePassword = ""
    @Published var isAllTextFieldAreTyped = false
    @Published var isAllTextFiledAreBlank = true
    
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
    
    func updatePassword() {
        changePasswordService.getAPI(userId: userInfor.employeeId, oldPass: self.oldPassword, newPass: self.newPassword)
    }
}
