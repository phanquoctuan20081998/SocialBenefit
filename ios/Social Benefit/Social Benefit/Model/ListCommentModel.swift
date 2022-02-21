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
    
    mutating func deleteComment(comment: CommentResultModel) {
        result = result?.filter({ model in
            return (model.id != comment.id && model.parentId != comment.id)
        })
    }
    
    mutating func updateComment(comment: CommentResultModel) {
        
        if result != nil {
            for i in 0 ..< result!.count {
                if result![i].id == comment.id {
                    result![i].commentDetail = comment.commentDetail
                    break
                }
            }
        }
    }
    
    mutating func updateCommentReact(id: Int?, reactType: ReactionType) {
        if result != nil {
            for i in 0 ..< result!.count {
                if result![i].id == id {
                    if result![i].reactionType == .none {
                        result![i].myReactType = reactType.rawValue
                    } else {
                        if result![i].reactionType != reactType {
                            result![i].myReactType = reactType.rawValue
                        } else {                            
                            result![i].myReactType = ReactionType.none.rawValue
                        }
                    }
                    break
                }
            }
        }
    }
    
    mutating func updateCommentDetail(_ newComment: CommentResultModel) {
        if result != nil {
            for i in 0 ..< result!.count {
                if result![i].id == newComment.id {
                    result![i].myReactType = newComment.myReactType
                    result![i].reactTop1 = newComment.reactTop1
                    result![i].reactTop2 = newComment.reactTop2
                    result![i].rectCount = newComment.rectCount
                    break
                }
            }
        }
    }
}

struct CommentResultModel: APIModelProtocol, Identifiable {
    var id: Int
    var contentId: Int?
    var parentId: Int?
    var avatar: String?
    var commentBy: String?
    var commentByEmployeeId: Int?
    var commentDetail: String?
    var commentTime: Int?
    var commentType: Int?
    var myReactType: Int?
    var reactTop1: Int?
    var reactTop2: Int?
    var rectCount: Int?
    
    var children: [CommentResultModel]?
    
    var timeText: String {
        if let time = commentTime {
            return getFullDateSince1970(date: time)
        }
        return ""
    }
    
    var reactionType: ReactionType {
        if let myReactType = myReactType, let type = ReactionType.init(rawValue: myReactType) {
            return type
        }
        return .none
    }
    
    var reactionTypeTop1: ReactionType {
        if let reactTop1 = reactTop1, let type = ReactionType.init(rawValue: reactTop1) {
            return type
        }
        return .none
    }
    
    var reactionTypeTop2: ReactionType {
        if let reactTop2 = reactTop2, let type = ReactionType.init(rawValue: reactTop2) {
            return type
        }
        return .none
    }
    
    var rectCountText: String {
        if let count = rectCount, count > 0 {
            return count.string
        }
        return ""
    }
    
    mutating func updateNewComment(_ text: String?) {
        commentDetail = text
    }
}
