//
//  BuyVoucherResultModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import Foundation

struct BuyVoucherModel: APIResponseProtocol {
    var status: Int?
    var result: BuyVoucherResultModel?
}

struct BuyVoucherResultModel: APIModelProtocol {
    var success: Bool
    var errorCode: String?
    var messsage: String?
    var voucherOrderId: Int?
}
