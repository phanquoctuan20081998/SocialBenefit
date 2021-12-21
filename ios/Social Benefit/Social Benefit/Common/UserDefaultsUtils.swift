//
//  UserDefaultsKey.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKey: String {
        case loginRember
        case companyCode
        case employeeId
        case password
        case appLanguage
    }
    
    static func getCompanyCode() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.companyCode.rawValue) ?? ""
    }
    
    static func setCompanyCode(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.companyCode.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getEmployeeId() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.employeeId.rawValue) ?? ""
    }
    
    static func setEmployeeId(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.employeeId.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getPassword() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.password.rawValue) ?? ""
    }
    
    static func setPassword(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.password.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getLoginRemember() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKey.loginRember.rawValue)
    }
    
    static func setLoginRemember(value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.loginRember.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getAppLanguage() -> AppLanguage {
        if let value = UserDefaults.standard.string(forKey: UserDefaultsKey.appLanguage.rawValue) {
            return AppLanguage.init(rawValue: value) ?? .en
        }
        return .en
    }
    
    static func setAppLanguage(value: AppLanguage) {
        UserDefaults.standard.set(value.rawValue, forKey: UserDefaultsKey.appLanguage.rawValue)
        UserDefaults.standard.synchronize()
    }
}
