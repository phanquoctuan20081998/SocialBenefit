//
//  RecentlyVoucherModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 21/02/2022.
//

import Foundation

struct RecentlyVoucherModel: APIResponseProtocol {
    var status: Int?
    var result: [RecentlyVoucherResultModel]?
    var messages: [String]?
}

struct RecentlyVoucherResultModel: APIModelProtocol, Identifiable, Equatable, Hashable {
    var id: Int
    var name: String?
    var merchantName: String?
    var pointValue: Int?
    var moneyValue: Int?
    var discountValue: Int?
    var hotlines: String?
    var merchantId: Int?
    var canBuy: Bool?
    var shoppingValue: Int?
    var outOfDateTime: String?
    var favoriteValue: Int?
    var content: String?
    var imageURL: String?
    var voucherCode: String?
    
    var imgLink: String {
        return Config.baseURL + (imageURL ?? "")
    }
    
    var voucherTilte: String {
        return "[\(merchantName ?? "")] \(name ?? "")"
    }
    
    var moneyValueText: String {
        let number = Utils.formatPointText(point: moneyValue)
        return number + "VND"
    }
    
    var discountValueText: String {
        return (discountValue?.string ?? "") + "%"
    }
    
    var favoriteValueBool: Bool {
        return favoriteValue?.boolValue ?? false
    }
    
    var pointValueText: String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        if let pointValue = pointValue {
            let number = nf.string(from: NSNumber.init(value: pointValue)) ?? ""
            let point: String
            if pointValue < 2 {
                point = "point".localized
            } else {
                point = "points".localized
            }
            return number + " " + point
        }
        return "point".localized
    }
}
