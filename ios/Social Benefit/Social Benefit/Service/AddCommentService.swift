//
//  AddCommentService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class AddCommentService {
    
    func getAPI(contentId: Int, contentType: Int, parentId: Int, content: String, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters
        
        if parentId == -1 {
            params = ["employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": contentType,
                      "content": content]
        } else {
            params = ["employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": contentType,
                      "parentId": parentId,
                      "content": content]
        }
        
        
        service.makeCall(endpoint: Config.API_COMMENT_ADD, method: "POST", header: header as [String : String], body: params, callback: { result in
            let newCommentId = result["id"].int ?? -1
            returnCallBack(newCommentId)
        })
    }
}

