//
//  ReactListRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation

struct ReactListRequestModel: APIModelProtocol {
    var reactType: Int?
    var contentType: Int?
    var contentId: Int?
    var fromIndex: Int?
}
