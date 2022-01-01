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
    @Published var image = UIImage(color: .white)
    @Published var imageName = userInfor.avatar
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
    
    // Loading controller
    
    @Published var isUpdating: Bool = false
    
    private var userInformationService = UserInformationService()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
        guard let url = URL(string: Config.baseURL + userInfor.avatar) else { return }
        UIImage.loadFrom(url: url) { image in
            guard let image = image else {
                self.image = UIImage(color: .white)
                return
            }
            self.image = image
        }
        
        self.addSubscribers()
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
            self.phoneText = trimStringWithNChar(15, string: phoneText)
            checkEnableSendButton()
        }
    }
    
    func checkEnableSendButton() {
        if nicknameText != userInfor.nickname || emailText != userInfor.email ||
            phoneText != userInfor.phone  || locationText != userInfor.address || imageName != userInfor.avatar {
            isEnableSaveButton = true
        } else {
            isEnableSaveButton = false
        }
    }
    
    func saveButtonTapped() {
        
        // Check email fommat...
        let emailText = emailText.trimmingCharacters(in: .whitespaces)
        let phoneText = phoneText.trimmingCharacters(in: .whitespaces)
        
        print(emailText)
        
        if emailText.isEmpty || phoneText.isEmpty {
            DispatchQueue.main.async {
                if self.phoneText.isEmpty { self.isPresentPhoneBlankError = true }
                if self.emailText.isEmpty { self.isPresentEmailBlankError = true }
            }
            
            return
        }
        
        if !textFieldValidatorEmail(emailText) {
            isPresentWrongEmailError = true
            return
        }
        
        // Update UserInfor...
        if !isPresentPhoneBlankError && !isPresentEmailBlankError && !isPresentWrongEmailError {
            userInforUpdate()
        }
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
        
        
        self.isUpdating = true
        
        if image == UIImage(color: .white) {
            userInformationService.sendImageAPI(id: userInfor.employeeId, nickName: self.nicknameText, address: noStreet, citizenId: userInfor.citizenId, email: self.emailText, phone: self.phoneText, birthday: birthday, locationId: self.locationId, image: self.image!, imageName: self.imageName) { data in
                
                if !data.isEmpty {
                    self.isSuccessed = true
                    
                    let employeeDto = data
                    let citizen = employeeDto["citizen"]
                    
                    DispatchQueue.main.async {
                        updateUserInfor(token: userInfor.token, employeeDto: employeeDto, citizen: citizen, functionNames: userInfor.functionNames)
                        self.imageName = employeeDto["avatar"].string ?? ""
                        
                        self.isUpdating = false
                    }
                }
            }
        } else {
            userInformationService.getAPI(id: userInfor.employeeId, nickName: self.nicknameText, address: noStreet, citizenId: userInfor.citizenId, email: self.emailText, phone: self.phoneText, birthday: birthday, locationId: self.locationId) { data in
//                if !data.isEmpty {
//                    self.isSuccessed = true
//
//                    let employeeDto = data
//                    let citizen = employeeDto["citizen"]
//
//                    DispatchQueue.main.async {
//                        updateUserInfor(token: userInfor.token, employeeDto: employeeDto, citizen: citizen, functionNames: userInfor.functionNames)
//                        self.imageName = employeeDto["avatar"].string ?? ""
//
//                        self.isUpdating = false
//                    }
//                }
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

public extension UIImage {
      convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
      }
    }
