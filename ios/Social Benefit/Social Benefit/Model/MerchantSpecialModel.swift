//
//  MerchantSpecialModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 20/01/2022.
//

import Foundation

struct MerchantSpecialSettingData {
    private var settingCode: String
    private var settingValue: String
    
    public init() {
        settingCode = ""
        settingValue = ""
    }
    
    public func getSettingCode() -> String {
        return settingCode
    }
    
    public mutating func setSettingCode(settingCode: String) {
        self.settingCode = settingCode
    }
    
    public func getSettingVallue() -> String {
        return settingValue
    }
    
    public mutating func setSettingValue(settingValue: String) {
        self.settingValue = settingValue
    }
}

struct MerchantSpecialData {
    private var id: Int
    private var merchantCode: String
    private var merchantName: String
    private var merchantSpecialSetting: [MerchantSpecialSettingData]
    
    public init() {
        id = 0
        merchantCode = ""
        merchantName = ""
        merchantSpecialSetting = []
    }
    
    public func getId() -> Int {
        return id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getMerchantCode() -> String {
        return merchantCode
    }
    
    public mutating func setMerchantCode(merchantCode: String) {
        self.merchantCode = merchantCode
    }
    
    public func getMerchantName() -> String {
        return merchantName
    }
    
    public mutating func setMerchantName(merchantName: String) {
        self.merchantName = merchantName
    }
    
    public func getMerchantSpecialSetting() -> [MerchantSpecialSettingData] {
        return merchantSpecialSetting
    }
    
    public mutating func setMerchantSpecialSetting(merchantSpecialSetting: [MerchantSpecialSettingData]) {
        self.merchantSpecialSetting = merchantSpecialSetting
    }
}

