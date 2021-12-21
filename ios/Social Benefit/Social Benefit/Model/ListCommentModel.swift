//
//  ListCommentModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import SwiftUI

struct ListCommentModel: APIResponseProtocol {
    var status: Int?
    var result: [CommentResultModel]?
    
    var comments: [CommentResultModel] {
        if let result = result {
            var list = result.filter { model in
                return model.parentId == nil
            }
            
            for i in 0 ..< list.count {
                var child = result.filter({ model in
                    return model.parentId == list[i].id
                })
                child = child.sorted(by: { c1, c2 in
                    if let time1 = c1.commentTime, let time2 = c2.commentTime {
                        return time1 < time2
                    }
                    return false
                })
                list[i].children = child
            }
            return list
        }
        return []
    }
}

struct CommentResultModel: APIModelProtocol, Identifiable {
    var id: Int?
    var contentId: Int?
    var parentId: Int?
    var avatar: String?
    var commentBy: String?
    var commentByEmployeeId: Int?
    var commentDetail: String?
    var commentTime: Int?
    
    var children: [CommentResultModel]?
    
    var timeText: String {
        if let time = commentTime {
            return getFullDateSince1970(date: time)
        }
        return ""
    }
}
