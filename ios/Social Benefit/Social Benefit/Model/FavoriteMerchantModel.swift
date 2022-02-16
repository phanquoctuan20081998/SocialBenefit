//
//  FavoriteMerchantModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import Foundation

struct FavoriteMerchantModel: APIResponseProtocol {
    var status: Int?
    var result: [FavoriteMerchantResultModel]?
}

struct FavoriteMerchantResultModel: APIModelProtocol, Identifiable, Equatable {
    var fullName: String?
    var id: Int
    var hotlines: String?
    var logo: String?
    var fullAddress: String?
}
