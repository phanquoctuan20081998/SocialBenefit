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
    
    @Published var allComment: [CommentData] = []
    
    init(contentId: Int) {
        self.getAPI(contentId)
    }
    
    func getAPI(_ contentId: Int) {
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
        
        service.makeCall(endpoint: Constant.API_COMMENT_LIST, method: "POST", header: header as [String : String], body: params, callback: { result in
            for i in 0..<result.count {
                id = result[i]["id"].int ?? 0
                contentId = result[i]["contentId"].int ?? 0
                parentId = result[i]["parentId"].int ?? -1 // if comment not rely anything
                avatar = result[i]["avatar"].string ?? ""
                commentBy = result[i]["commentBy"].string ?? ""
                commentDetail = result[i]["commentDetail"].string ?? ""
                let commentTimeInt = result[i]["commentTime"].int ?? 0
                
                commentTime = self.getDate(date: commentTimeInt)
                
                let tempCommentData = CommentData(id: id!, contentId: contentId!, parentId: parentId!, avatar: avatar!, commentBy: commentBy!, commentDetail: commentDetail!, commentTime: commentTime!)
                data.append(tempCommentData)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.allComment = data
            }
        })
    }
    
    func getDate(date: Int) -> String {
        let commentDate = Date(timeIntervalSince1970: Double(date / 1000))
        let diffirent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: commentDate, to: Date())
        
        if diffirent.year != 0 {
            return "\(String(describing: diffirent.year!)) " + ((diffirent.year == 1) ? "year".localized : "years".localized)
        } else if diffirent.month != 0 {
            return "\(String(describing: diffirent.month!)) " + ((diffirent.month == 1) ? "month".localized : "months".localized)
        } else if diffirent.day != 0 {
            return "\(String(describing: diffirent.day!)) " + ((diffirent.day == 1) ? "day".localized : "days".localized)
        } else if diffirent.hour != 0 {
            return "\(String(describing: diffirent.hour!)) " + ((diffirent.hour == 1) ? "hour".localized : "hours".localized)
        } else if diffirent.minute != 0 {
            return "\(String(describing: diffirent.minute!)) " + ((diffirent.minute == 1) ? "minute".localized : "minutes".localized)
        } else {
            return "\(String(describing: diffirent.second!)) " + ((diffirent.second == 1) ? "second".localized : "seconds".localized)
        }
    }
}
