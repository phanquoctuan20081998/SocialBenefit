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
    
    var list: [ReactCountResultModel] {
        if var result = result {
            if result.count == 2 {
                result = result.filter({ model in
                    return model.reactType != -1
                })
            }
            return result
        } else {
            return []
        }
    }
}

struct ReactCountResultModel: APIModelProtocol {
    var reactType: Int?
    var reactCount: Int?
}
