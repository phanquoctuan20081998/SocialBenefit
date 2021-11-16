//
//  CommentService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 31/08/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

    
class CommentService {
    
//    @Published var allComment: [CommentData] = []
    
    func getAPI(_ contentId: Int, returnCallBack: @escaping ([CommentData]) -> ()) {
        let service = BaseAPI()
        var data = [CommentData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "contentId": String(contentId),
                      "contentType": "1"]
    
        let params: Parameters = ["": ""]
        
        var id: Int?
        var contentId: Int?
        var parentId: Int?
        var avatar: String?
        var commentBy: String?
        var commentDetail: String?
        var commentTime: String?
        
        service.makeCall(endpoint: Config.API_COMMENT_LIST, method: "POST", header: header as [String : String], body: params, callback: { result in
            for i in 0..<result.count {
                id = result[i]["id"].int ?? 0
                contentId = result[i]["contentId"].int ?? 0
                parentId = result[i]["parentId"].int ?? -1 // if comment not rely anything
                avatar = result[i]["avatar"].string ?? ""
                commentBy = result[i]["commentBy"].string ?? ""
                commentDetail = result[i]["commentDetail"].string ?? ""
                let commentTimeInt = result[i]["commentTime"].int ?? 0
                
                commentTime = getFullDateSince1970(date: commentTimeInt)
                
                let tempCommentData = CommentData(id: id!, contentId: contentId!, parentId: parentId!, avatar: avatar!, commentBy: commentBy!, commentDetail: commentDetail!, commentTime: commentTime!)
                data.append(tempCommentData)
            }
            
            returnCallBack(data)
        })
    }
}
