//
//  VoucherModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import Foundation

struct MyVoucherData: Identifiable, Hashable {
    var id: Int
    var voucherOrderId: Int
    var title: String
    var cover: String
    var expriedDate: Date
    var merchantName: String
}
