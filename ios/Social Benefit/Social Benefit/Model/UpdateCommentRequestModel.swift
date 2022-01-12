//
//  UpdateCommentReqeustModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 11/01/2022.
//

import Foundation

struct UpdateCommentRequestModel: APIModelProtocol {
    
    var id: Int?
    var employeeId = userInfor.employeeId
    var contentId: Int?
    var parentId: Int?
    var contentType: Int?
    var content: String?
    
    init(comment: CommentResultModel?) {
        self.id = comment?.id
        self.contentId = comment?.contentId
        self.parentId = comment?.parentId
        self.contentType = comment?.commentType
        self.content = comment?.commentDetail
    }
}
