//
//  UserInformationViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/10/2021.
//

import Foundation
import SwiftUI

class UserInformationViewModel: ObservableObject, Identifiable {
    
    @Published var nicknameText = userInfor.nickname
    @Published var genderText = userInfor.gender.localized
    @Published var insuranceText = userInfor.insurance
    @Published var passportText = userInfor.passport
    @Published var emailText = userInfor.email
    @Published var phoneText = userInfor.phone
    
    //State variants to control Image Picker
    @Published var isPresentedImagePicker = false
    @Published var image = UIImage(named: userInfor.avatar)
    @Published var showGallery: Bool = false
    @Published var showCamera: Bool = false
    
    //State variants to control Date Picker field
    @Published var isPresentedDatePickerPopUp = false
    @Published var isChangedDatePickerPopUp = false
    @Published var dateText = userInfor.birthday
    @Published var currentDate = Date()
    
    //State variants to control Location Picker field
    @Published var isPresentedLocationPickerView = false
    @Published var endDragOffsetY: CGFloat = 0
    @Published var filter = ""
    @Published var locationText = userInfor.address
    @Published var curLocationText = ""
    
}
