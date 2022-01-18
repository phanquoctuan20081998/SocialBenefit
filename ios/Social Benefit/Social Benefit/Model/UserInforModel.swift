//
//  UserInforModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation
import UIKit
import SwiftyJSON

struct UserInfor {
    var userId: String
    var employeeId: String
    var token: String
    var companyId: String
    var name: String
    var avatar: String
    var position: String
    var nickname: String
    var email: String
    var phone: String
    var noStreet: String
    var ward: String
    var district: String
    var city: String
    var address: String
    var birthday: Date
    var gender: String
    var CMND: String
    var passport: String
    var insurance: String
    var department: String
    var isLeader: Bool
    var companyLogo: String
    var citizenId: String
    var locationId: String
    var clientId: String
    var clientSecret: String
    var functionNames: [String]
    
    init(userId: String, employeeId: String, token: String, companyId: String, name: String, avatar: String, position: String, nickname: String, email: String, phone: String, noStreet: String, ward: String, district: String, city: String, address: String, birthday: Date, gender: String, CMND: String, passport: String, insurance: String, department: String, isLeader: Bool, companyLogo: String, citizenId: String, locationId: String, clientId: String, clientSecret: String, functionNames: [String]) {
        
        self.userId = userId
        self.employeeId = employeeId
        self.token = token
        self.companyId = companyId
        self.name = name
        self.avatar = avatar
        self.position = position
        self.nickname = nickname
        self.email = email
        self.phone = phone
        self.noStreet = noStreet
        self.ward = ward
        self.district = district
        self.city = city
        self.address = address
        self.birthday = birthday
        self.gender = gender
        self.CMND = CMND
        self.passport = passport
        self.insurance = insurance
        self.department = department
        self.isLeader = isLeader
        self.companyLogo = companyLogo
        self.citizenId = citizenId
        self.locationId = locationId
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.functionNames = functionNames
    }
    
    // For initialize User Information without token infor
    init(employeeDto: JSON, citizen: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        self.userId = employeeDto["employeeCode"].string ?? ""
        self.employeeId = String(employeeDto["id"].int ?? 0)
        self.token = ""
        self.companyId = String(employeeDto["company"]["id"].int ?? 0)
        self.name = employeeDto["citizen"]["fullName"].string ?? ""
        self.avatar = employeeDto["avatar"].string ?? ""
        self.position = employeeDto["position"]["name"].string ?? ""
        self.nickname = employeeDto["nickName"].string ?? ""
        self.email = employeeDto["email"].string ?? ""
        self.phone = employeeDto["phone"].string ?? ""
        self.department = employeeDto["department"]["name"].string ?? ""
        self.isLeader = employeeDto["isPointManager"].bool ?? false
        self.companyLogo = employeeDto["company"]["logo"].string ?? ""
        
        self.noStreet = citizen["noStreet"].string ?? ""
        self.ward = citizen["locationWard"]["name"].string ?? ""
        self.district = citizen["locationDistrict"]["name"].string ?? ""
        self.city = citizen["locationCity"]["name"].string ?? ""
        self.address = self.noStreet + ", " + self.ward + ", " + self.district + ", " + self.city
        self.birthday = dateFormatter.date(from: citizen["birthDayStr"].string ?? "01/01/0001") ?? Date()
        if (citizen["sex"].int ?? 0 == 0) {self.gender = "male"}
        else if(citizen["sex"].int ?? 0 == 1) {self.gender = "female"}
        else {self.gender = "other"}
        self.CMND = citizen["idCard"].string ?? ""
        self.passport = citizen["passport"].string ?? ""
        self.insurance = citizen["socialInsurance"].string ?? ""
        self.citizenId = String(citizen["id"].int ?? 0)
        self.locationId = citizen["locationWard"]["id"].string ?? "00000"
        self.clientId = employeeDto["company"]["clientId"].string ?? ""
        self.clientSecret = employeeDto["company"]["clientSecret"].string ?? ""
        self.functionNames = []
    }
}

var userInfor = UserInfor(userId: "", employeeId: "", token: "", companyId: "", name: "ABCD", avatar: "", position: "", nickname: "",
                          email: "", phone: "", noStreet: "", ward: "", district: "", city: "", address: "", birthday: Date(), gender: "",
                          CMND: "", passport: "", insurance: "", department: "", isLeader: false, companyLogo: UserDefaults.getCompanyLogo(), citizenId: "", locationId: "", clientId: "", clientSecret: "", functionNames: [])


func updateUserInfor(token: String, employeeDto: JSON, citizen: JSON, functionNames: [String]) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    userInfor.userId = employeeDto["employeeCode"].string ?? ""
    userInfor.employeeId = String(employeeDto["id"].int ?? 0)
    userInfor.token = token
    userInfor.companyId = String(employeeDto["company"]["id"].int ?? 0)
    userInfor.name = employeeDto["citizen"]["fullName"].string ?? ""
    userInfor.avatar = employeeDto["avatar"].string ?? ""
    userInfor.position = employeeDto["position"]["name"].string ?? ""
    userInfor.nickname = employeeDto["nickName"].string ?? ""
    userInfor.email = employeeDto["email"].string ?? ""
    userInfor.phone = employeeDto["phone"].string ?? ""
    userInfor.department = employeeDto["department"]["name"].string ?? ""
    userInfor.isLeader = employeeDto["isPointManager"].bool ?? false
    userInfor.companyLogo = employeeDto["company"]["logo"].string ?? ""
    
    userInfor.noStreet = citizen["noStreet"].string ?? ""
    userInfor.ward = citizen["locationWard"]["name"].string ?? ""
    userInfor.district = citizen["locationDistrict"]["name"].string ?? ""
    userInfor.city = citizen["locationCity"]["name"].string ?? ""
    userInfor.address = userInfor.noStreet + ", " + userInfor.ward + ", " + userInfor.district + ", " + userInfor.city
    userInfor.birthday = dateFormatter.date(from: citizen["birthDayStr"].string ?? "01/01/0001") ?? Date()
    if (citizen["sex"].int ?? 0 == 0) {userInfor.gender = "male"}
    else if(citizen["sex"].int ?? 0 == 1) {userInfor.gender = "female"}
    else {userInfor.gender = "other"}
    userInfor.CMND = citizen["idCard"].string ?? ""
    userInfor.passport = citizen["passport"].string ?? ""
    userInfor.insurance = citizen["socialInsurance"].string ?? ""
    userInfor.citizenId = String(citizen["id"].int ?? 0)
    userInfor.locationId = citizen["locationWard"]["id"].string ?? "00000"
    userInfor.clientId = employeeDto["company"]["clientId"].string ?? ""
    userInfor.clientSecret = employeeDto["company"]["clientSecret"].string ?? ""
    userInfor.functionNames = functionNames
    
//    print(userInfor)
}

func updateUserInfor(model: LoginModel) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    userInfor.userId = model.result?.employeeDto?.employeeCode ?? ""
    userInfor.employeeId = model.result?.employeeDto?.id?.string ?? "0"
    userInfor.token = model.result?.token ?? ""
    userInfor.companyId = model.result?.employeeDto?.company?.id?.string ?? "0"
    userInfor.name = model.result?.employeeDto?.citizen?.fullName ?? ""
    userInfor.avatar = model.result?.employeeDto?.avatar ?? ""
    userInfor.position = model.result?.employeeDto?.position?.name ?? ""
    userInfor.nickname = model.result?.employeeDto?.nickName ?? ""
    userInfor.email = model.result?.employeeDto?.email ?? ""
    userInfor.phone = model.result?.employeeDto?.phone ?? ""
    userInfor.department = model.result?.employeeDto?.department?.name ?? ""
    userInfor.isLeader = model.result?.employeeDto?.isPointManager ?? false
    userInfor.companyLogo = model.result?.employeeDto?.company?.logo ?? ""
    userInfor.noStreet = model.result?.employeeDto?.citizen?.noStreet ?? ""
    userInfor.ward = model.result?.employeeDto?.citizen?.locationWard?.name ?? ""
    userInfor.district = model.result?.employeeDto?.citizen?.locationDistrict?.name ?? ""
    userInfor.city = model.result?.employeeDto?.citizen?.locationCity?.name ?? ""
    userInfor.address = userInfor.noStreet + ", " + userInfor.ward + ", " + userInfor.district + ", " + userInfor.city
    if let birthDay = model.result?.employeeDto?.citizen?.birthDayStr {
        userInfor.birthday = dateFormatter.date(from: birthDay) ?? Date()
    }
    if model.result?.employeeDto?.citizen?.sex == 0 {
        userInfor.gender = "male"
    } else if model.result?.employeeDto?.citizen?.sex == 1 {
        userInfor.gender = "female"
    } else {
        userInfor.gender = "other"
    }
    userInfor.CMND = model.result?.employeeDto?.citizen?.idCard ?? ""
    userInfor.passport = model.result?.employeeDto?.citizen?.passport ?? ""
    userInfor.insurance = model.result?.employeeDto?.citizen?.socialInsurance ?? ""
    userInfor.citizenId = model.result?.employeeDto?.citizen?.id?.string ?? "0"
    userInfor.locationId = model.result?.employeeDto?.citizen?.locationWard?.id ?? ""
    userInfor.clientId = model.result?.employeeDto?.company?.clientId ?? ""
    userInfor.clientSecret = model.result?.employeeDto?.company?.clientSecret ?? ""
    userInfor.functionNames = model.result?.functionNames ?? []
    
    print(userInfor)
    
    UserDefaults.setCompanyLogo(value: userInfor.companyLogo)
}
