//
//  ReactCountModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation

struct ReactCountModel: APIResponseProtocol {
    var status: Int?
    var result: [ReactCountResultModel]?
}

struct ReactCountResultModel: APIModelProtocol {
    var reactType: Int?
    var reactCount: Int?
}
