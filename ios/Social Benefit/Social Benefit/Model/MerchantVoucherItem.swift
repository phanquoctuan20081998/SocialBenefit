//
//  MerchantVoucherItem.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/09/2021.
//

import Foundation

struct MerchantVoucherItemData: Identifiable, Hashable {
    var id: Int
    var voucherCode: Int
    var imageURL: String
    var name: String
    var merchantName: String
    var content: String
    var favoriteValue: Int
    var outOfDateValue: Date
    var shoppingValue: Int
    var pointValue: Int64
    var moneyValue: Int64
    var discountValue: Int
    var categoryId: Int
    var merchantId: Int
    var employeeLikeThis: Bool
}
