//
//  BuyVoucherModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 21/09/2021.
//

import Foundation

struct  BuyVoucherData: Hashable {
    var success: Bool
    var message: String
    var voucherOrderId: Int
    var errorCode: String
    
    init() {
        success = true
        message = ""
        voucherOrderId = -1
        errorCode = ""
    }
    
    init(success: Bool, message: String, voucherOrderId: Int, errorCode: String) {
        self.success = success
        self.message = message
        self.voucherOrderId = voucherOrderId
        self.errorCode = errorCode
    }
}
