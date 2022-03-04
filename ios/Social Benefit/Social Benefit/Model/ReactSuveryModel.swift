//
//  ReactSuveryModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import SwiftUI

struct ReactSuveryModel: APIResponseProtocol {
    var status: Int?
    var result: [ReactResultModel]?
    var messages: [String]?
    
    var imageName: String {
        if let result = result, result.count > 0 {
            let myFilter = result.filter({ model in
                return model.employeeId?.string == userInfor.employeeId
            })
            if let type = myFilter.first?.reactType, type < 6 {
                
            }
        }
        return ""
    }
    
    var allReactionText: String {
        if let result = result, result.count > 0 {
            if myRectionType != .none {
                if result.count == 1 {
                    return "you".localized
                } else {
                    return "you_and %d".localizeWithFormat(arguments: result.count - 1)
                }
            } else {
                return "%d other".localizeWithFormat(arguments: result.count)
            }
        }
        return ""
    }
    
    var myReactionText: String {
        if let result = result, result.count > 0 {
            if myRectionType != .none {
                return myRectionType.name.localized
            } else {
                return "like".localized
            }
        }
        return "no_like".localized
    }
    
    var myFilter: ReactResultModel? {
        let filter = result?.filter({ model in
            return model.employeeId?.string == userInfor.employeeId
        })
        return filter?.first
    }
    
    var myRectionType: ReactionType {
        if let myFilter = myFilter, let type = myFilter.reactType {
            return ReactionType.init(rawValue: type) ?? .none
        }
        return .none
    }
    
    var maxReactionType: [ReactionType] {
        var array: [ReactionType] = []
        if let result = result {
            let dictionary = result.reduce(into: [:]) { counts, react in
                counts[react.reactType, default: 0] += 1
            }
            let max = dictionary.sorted { d1, d2 in
                if d1.value == d2.value {
                    if let k1 = d1.key, let k2 = d2.key {
                        return k1 > k2
                    }
                    return true
                } else {
                    return d1.value > d2.value
                }
            }.prefix(2)
            max.forEach { e in
                if let key = e.key, let reactType = ReactionType.init(rawValue: key) {
                    array.append(reactType)
                }
            }
        }
        return array
    }
}

struct ReactResultModel: APIModelProtocol {
    var id: Int?
    var employeeId: Int?
    var reactType: Int?
    var name: String?
    var avatar: String?
}
