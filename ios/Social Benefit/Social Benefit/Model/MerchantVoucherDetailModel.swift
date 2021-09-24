//
//  MerchantVoucherDetailModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation

struct MerchantVoucherDetailData: Identifiable, Hashable {
    var id: Int
    var imageURL: String
    var name: String
    var merchantName: String
    var content: String
    var favoriteValue: Int
    var outOfDate: String
    var shoppingValue: Int
    var pointValue: Int64
    var moneyValue: Int64
    var discountValue: Int
    var hotlines: String
    var employeeLikeThis: Bool
}
