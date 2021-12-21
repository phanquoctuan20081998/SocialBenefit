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
}

struct ReactResultModel: APIModelProtocol {
    var id: Int?
    var employeeId: Int?
    var reactType: Int?
    var name: String?
    var avatar: String?
}
