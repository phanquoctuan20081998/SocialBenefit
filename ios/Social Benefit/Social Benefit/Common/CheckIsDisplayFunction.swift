//
//  CheckIsDisplayFunction.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 03/12/2021.
//

import Foundation

func isDisplayFunction(_ functionName: String) -> Bool {
    
    if userInfor.functionNames.isEmpty {
        return false
    }
    
    return userInfor.functionNames.contains(functionName)
}

func isDisplayMerchantSpecial(_ merchantCode: String) -> Bool {
    if userInfor.merchantSpecial.isEmpty {
        return false
    }
    
    return userInfor.merchantSpecial.contains(where: { $0.merchantCode == merchantCode })
}
