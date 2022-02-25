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

struct FavoriteMerchantResultModel: APIModelProtocol, Identifiable, Equatable, Hashable {
    var fullName: String?
    var id: Int
    var hotlines: String?
    var logo: String?
    var fullAddress: String?
    
    init() {
        fullName = ""
        id = 0
        hotlines = ""
        logo = ""
        fullAddress = ""
    }
    
    init(fullName: String, id: Int, hotlines: String, logo: String, fullAddress: String) {
        self.fullName = fullName
        self.id = id
        self.hotlines = hotlines
        self.logo = logo
        self.fullAddress = fullAddress
    }
}
