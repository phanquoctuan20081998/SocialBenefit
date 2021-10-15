//
//  PreviousUserLoginInfor.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import Foundation

struct PreviousUserLoginInfor {
    var companyCode: String
    var employeeId: String
    var password: String
    var language: Int
    
    var isRemember: Bool
}

var previousUserLoginInfor = PreviousUserLoginInfor(companyCode: UserDefaults.standard.string(forKey: "companyCode") ?? "",
                                                    employeeId: UserDefaults.standard.string(forKey: "employeeId") ?? "",
                                                    password: UserDefaults.standard.string(forKey: "password") ?? "",
                                                    language: 0,
                                                    isRemember: UserDefaults.standard.bool(forKey: "isChecked"))
