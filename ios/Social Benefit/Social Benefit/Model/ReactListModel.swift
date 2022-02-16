//
//  ReactListModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation

struct ReactListModel: APIResponseProtocol {
    var status: Int?
    var result: [ReactListResultModel]?
}

struct ReactListResultModel: APIModelProtocol, Identifiable, Equatable, Hashable {
    var id: Int?
    var avatar: String?
    var employeeName: String?
    var reactType: Int
}
