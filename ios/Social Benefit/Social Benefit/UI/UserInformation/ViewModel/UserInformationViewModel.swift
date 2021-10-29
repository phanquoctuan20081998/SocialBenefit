//
//  UserInformationViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/10/2021.
//

import Foundation
import SwiftUI
import Combine

class UserInformationViewModel: ObservableObject, Identifiable {
    
    @Published var nicknameText = userInfor.nickname
    @Published var genderText = userInfor.gender.localized
    @Published var insuranceText = userInfor.insurance
    @Published var passportText = userInfor.passport
    @Published var emailText = userInfor.email
    @Published var phoneText = userInfor.phone
    
    // To control Image Picker...
    @Published var isPresentedImagePicker = false
    @Published var image = UIImage(named: userInfor.avatar)
    @Published var showGallery: Bool = false
    @Published var showCamera: Bool = false
    
    // To control Date Picker field
    @Published var isPresentedDatePickerPopUp = false
    @Published var isChangedDatePickerPopUp = false
    @Published var dateText = userInfor.birthday
    @Published var currentDate = Date()
    
    // To control Location Picker field...
    @Published var isPresentedLocationPickerView = false
    @Published var endDragOffsetY: CGFloat = 0
    @Published var filter = ""
    @Published var locationText = userInfor.address
    @Published var curLocationText = ""
    @Published var locationId = userInfor.locationId
    @Published var noStreet = ""
    
    // To control error...
    @Published var isPresentWrongEmailError: Bool = false
    @Published var isPresentEmailBlankError: Bool = false
    @Published var isPresentPhoneBlankError: Bool = false
    @Published var isEnableSaveButton: Bool = false
    
    // To control popup
    @Published var isPresentConfirmPopUp: Bool = false
    @Published var isSuccessed: Bool = false
    
    private var userInformationService = UserInformationService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $nicknameText
            .sink(receiveValue: verifyNickname(nickname:))
            .store(in: &cancellables)
        
        $emailText
            .sink(receiveValue: verifyEmail(email:))
            .store(in: &cancellables)
        
        $phoneText
            .sink(receiveValue: verifyPhoneNumber(phoneText:))
            .store(in: &cancellables)
    }
    
    func verifyNickname(nickname: String) {
        DispatchQueue.main.async { [self] in
            self.nicknameText = trimStringWithNChar(90, string: nickname)
            checkEnableSendButton()
        }
    }
    
    func verifyEmail(email: String) {
        DispatchQueue.main.async { [self] in
            self.emailText = trimStringWithNChar(80, string: email)
            checkEnableSendButton()
        }
    }
    
    func verifyPhoneNumber(phoneText: String) {
        DispatchQueue.main.async { [self] in
            self.phoneText = trimStringWithNChar(10, string: phoneText)
            checkEnableSendButton()
        }
    }
    
    func checkEnableSendButton() {
        if nicknameText != userInfor.nickname || emailText != userInfor.email ||
            phoneText != userInfor.phone  || locationText != userInfor.address {
            isEnableSaveButton = true
        } else {
            isEnableSaveButton = false
        }
    }
    
    func saveButtonTapped() {
        
        // Check email fommat...
        
        if self.emailText.isEmpty || self.phoneText.isEmpty {
            if self.phoneText.isEmpty { self.isPresentPhoneBlankError = true }
            if self.emailText.isEmpty { self.isPresentEmailBlankError = true }
            return
        }
        
        if !textFieldValidatorEmail(self.emailText) {
            isPresentWrongEmailError = true
            return
        }
        
        // Update UserInfor...
        userInforUpdate()
    }
    
    func userInforUpdate() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let birthday = dateFormatter.string(from: userInfor.birthday)
        
        var noStreet = ""
        if self.noStreet.isEmpty {
            noStreet = userInfor.noStreet
        } else {
            noStreet = self.noStreet
        }
        
        userInformationService.getAPI(id: userInfor.employeeId, nickName: self.nicknameText, address: noStreet, citizenId: userInfor.citizenId, email: self.emailText, phone: self.phoneText, birthday: birthday, locationId: self.locationId) { isSuccessed in
            
            if isSuccessed {
                self.isSuccessed = isSuccessed
                userInfor.nickname = self.nicknameText
                userInfor.noStreet = self.noStreet
                userInfor.address = self.locationText
                userInfor.email = self.emailText
                userInfor.locationId = self.locationId
            }
        }
    }
    
    
    func resetError() {
        DispatchQueue.main.async {
            self.isPresentPhoneBlankError = false
            self.isPresentEmailBlankError = false
            self.isPresentWrongEmailError = false
        }
    }
}
