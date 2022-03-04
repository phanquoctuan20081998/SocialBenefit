//
//  BuyInforVoucherModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import Foundation

enum BuyInforStatus {
    case canBuy
    case outOfStock
    case ownedMaxVoucher
    case notEnoughRemainPoint
}

struct BuyInforVoucherModel: APIResponseProtocol {
    var status: Int?
    var result: BuyInforVoucherResultModel?
    var messages: [String]?
}

struct BuyInforVoucherResultModel: APIModelProtocol {
    var canUseNumber: Int?
    var orderedNumber: Int?
    var remainVoucherInStock: Int?
    var voucherPoint: Int?
    var remainPoint: Int?
    var maxCanBuyNumber: Int?
    
    var inforStatus: BuyInforStatus {
        if let remainVoucherInStock = remainVoucherInStock, let orderedNumber = orderedNumber, let voucherPoint = voucherPoint, let remainPoint = remainPoint {
            if remainVoucherInStock <= 0 {
                return .outOfStock
            } else {
                if let maxCanBuyNumber = maxCanBuyNumber, orderedNumber >= maxCanBuyNumber {
                    return .ownedMaxVoucher
                } else if remainPoint < voucherPoint {
                    return .notEnoughRemainPoint
                }
            }
        }
        
        return .canBuy
    }
    
    var popupTitle: String {
        if inforStatus == .outOfStock {
            return "voucher_is_out_of_stock".localized
        } else {
            if inforStatus == .ownedMaxVoucher {
                return "you_have_bought_max".localized
            }
        }        
        return "you_are_having".localized
    }
}
