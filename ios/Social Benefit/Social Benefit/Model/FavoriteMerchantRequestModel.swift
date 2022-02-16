//
//  FavoriteMerchanModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import Foundation

struct FavoriteMerchantRequestModel: APIModelProtocol {
    var searchPattern: String?
    var fromIndex: Int?
}
