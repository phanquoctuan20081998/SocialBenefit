//
//  DeleteCommentService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class DeleteCommentService {
    
    func getAPI(id: Int, contentId: Int, contentType: Int, parentId: Int, content: String, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters
        
        if parentId == -1 {
            params = ["id": id,
                      "employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": contentType,
                      "content": content]
        } else {
            params = ["id": id,
                      "employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": contentType,
                      "parentId": parentId,
                      "content": content]
        }
        
        
        service.makeCall(endpoint: Config.API_COMMENT_DELETE, method: "POST", header: header as [String : String], body: params, callback: { result in
            let newCommentId = result["id"].int ?? -1
            returnCallBack(newCommentId)
        })
    }
}


