//
//  AddCommentRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation

struct AddCommentRequestModel: APIModelProtocol {
    
    var employeeId = userInfor.employeeId
    var contentId: Int?
    var parentId: Int?
    var contentType: Int?
    var content: String?
    
    init(replyTo: CommentResultModel?, contentId: Int?, contentType: Int?, content: String) {
        if replyTo == nil {
            self.contentType = contentType
            self.contentId = contentId
            self.parentId = -1
        } else {
            self.contentType = Constants.CommentContentType.COMMENT_TYPE_COMMENT
            self.contentId = replyTo?.contentId
            self.parentId = replyTo?.id
        }
        self.content = content
    }
}
