//
//  FavoriteMerchantUpdateRequestModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 17/02/2022.
//

import Foundation

struct FavoriteMerchantUpdateRequestModel: APIModelProtocol {
    var merchantId: Int?
    var employeeId: String?
    var likeMerchant: Bool?
}
