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
}

var userInfor = UserInfor(userId: "", employeeId: "", token: "", companyId: "", name: "", avatar: "", position: "", nickname: "",
                          email: "", phone: "", noStreet: "", ward: "", district: "", city: "", address: "", birthday: Date(), gender: "",
                          CMND: "", passport: "", insurance: "", department: "", isLeader: false, companyLogo: "")


func updateUserInfor(userId: String, token: String, employeeDto: JSON, citizen: JSON) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    
    userInfor.userId = userId
    userInfor.employeeId = String(employeeDto["id"].int ?? 0)
    userInfor.token = token
    userInfor.companyId = String(employeeDto["company"]["id"].int ?? 0)
    userInfor.name = employeeDto["citizen"]["fullName"].string ?? ""
    userInfor.avatar = employeeDto["avatar"].string ?? ""
    userInfor.position = employeeDto["position"]["name"].string ?? ""
    userInfor.nickname = employeeDto["nickname"].string ?? ""
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
    if (citizen["sex"].int! == 0) {userInfor.gender = "male"}
    else if(citizen["sex"].int! == 1) {userInfor.gender = "female"}
    else {userInfor.gender = "other"}
    userInfor.CMND = citizen["idCard"].string ?? ""
    userInfor.passport = citizen["passport"].string ?? ""
    userInfor.insurance = citizen["socialInsurance"].string ?? ""
    
    
    print(userInfor)
}

