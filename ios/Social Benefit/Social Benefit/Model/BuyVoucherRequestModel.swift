//
//  BuyVoucherRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import Foundation

struct BuyVoucherRequestModel: APIModelProtocol {
    var voucherId: Int?
    var number: Int?
    var beforeBuyVoucherOrderCount: Int?
}
