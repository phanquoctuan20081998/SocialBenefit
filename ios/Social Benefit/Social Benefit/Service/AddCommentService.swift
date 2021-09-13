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
    
    @Published var newCommentId: Int = 0
    
    init(contentId: Int, parentId: Int, content: String) {
        self.getAPI(contentId: contentId, parentId: parentId, content: content)
    }
    
    private func getAPI(contentId: Int, parentId: Int, content: String) {
        let service = BaseAPI()
        
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters
        
        if parentId == -1 {
            params = ["employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": 1,
                      "content": content]
        } else {
            params = ["employeeId": userInfor.employeeId,
                      "contentId": contentId,
                      "contentType": 2,
                      "parentId": parentId,
                      "content": content]
        }
        
        
        service.makeCall(endpoint: Constant.API_COMMENT_ADD, method: "POST", header: header as [String : String], body: params, callback: { result in
            
            DispatchQueue.main.async {
                self.newCommentId = result["id"].int!
            }
        })
    }
}

