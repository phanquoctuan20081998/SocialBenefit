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
    
    init(replyTo: CommentResultModel?, surveyId: Int?, content: String) {
        if replyTo == nil {
            self.contentType = 3
            self.contentId = surveyId
            self.parentId = -1
        } else {
            self.contentType = 2
            self.contentId = replyTo?.contentId
            self.parentId = replyTo?.id
        }
        self.content = content
    }
}
