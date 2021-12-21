//
//  LoginModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation

struct LoginModel: APIResponseProtocol {
    var status: Int?
    var result: LoginResultMode?
}

struct LoginResultMode: APIModelProtocol {
    var token: String?
    var employeeDto: LoginEmployeeDto?
}

struct LoginEmployeeDto: APIModelProtocol {
    var id: Int?
    var departmentDivision: String?
    var phone: String?
    var email: String?
    var avatar: String?
    var nickName: String?
    var citizen: LoginCitizen?
    var employeeCode: String?
    var company: LoginCompany?
    var position: LoginPosition?
    var department: LoginPosition?
    var isPointManager: Bool?
}


struct LoginCitizen: APIModelProtocol {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var locationCity: LoginCitizenLocation?
    var locationDistrict: LoginCitizenLocation?
    var locationWard: LoginCitizenLocation?
    var birthDay: String?
    var birthDayStr: String?
    var sex: Int?
    var idCard: String?
    var fullName: String?
    var idCardEstablishDateStrValue: String?
    var fullNameRequest: String?
    var noStreet: String?
    var passport: String?
    var socialInsurance: String?
}

struct LoginCitizenLocation: APIModelProtocol {
    var id: String?
    var name: String?
    var parent_id: String?
}

struct LoginCompany: APIModelProtocol {
    var id: Int?
    var fullName: String?
    var logo: String?
}

struct LoginPosition: APIModelProtocol {
    var name: String?
}
