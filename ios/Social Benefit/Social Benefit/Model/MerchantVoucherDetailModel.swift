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
    var employeeLikeThisMerchant: Bool
    var merchantId: Int
    
    init() {
        id = 0
        imageURL = ""
        name = ""
        merchantName = ""
        content = ""
        favoriteValue = 0
        outOfDate = ""
        shoppingValue = 0
        pointValue = 0
        moneyValue = 0
        discountValue = 0
        hotlines = ""
        employeeLikeThis = false
        employeeLikeThisMerchant = false
        merchantId = 0
    }
    
    init(id: Int, imageURL: String, name: String, merchantName: String, content: String, favoriteValue: Int, outOfDate: String, shoppingValue: Int, pointValue: Int64, moneyValue: Int64, discountValue: Int, hotlines: String, employeeLikeThis: Bool, employeeLikeThisMerchant: Bool, merchantId: Int) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.merchantName = merchantName
        self.content = content
        self.favoriteValue = favoriteValue
        self.outOfDate = outOfDate
        self.shoppingValue = shoppingValue
        self.pointValue = pointValue
        self.moneyValue = moneyValue
        self.discountValue = discountValue
        self.hotlines = hotlines
        self.employeeLikeThis = employeeLikeThis
        self.employeeLikeThisMerchant = employeeLikeThisMerchant
        self.merchantId = merchantId
    }
}
