//
//  ReactService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

    
class ReactService {
    
    func getAPI(contentId: Int, returnCallBack: @escaping ([ReactData]) -> ()) {
        let service = BaseAPI()
        var data = [ReactData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "contentId": String(contentId),
                      "contentType": "1"]
    
        let params: Parameters = ["": ""]
        
        var id: Int?
        var employeeId: Int?
        var reactType: Int?
        var name: String?
        var avatar: String?
        
        service.makeCall(endpoint: Config.API_CONTENT_LIST_REACT, method: "POST", header: header as [String : String], body: params, callback: { result in
            for i in 0..<result.count {
                id = result[i]["id"].int ?? 0
                employeeId = result[i]["employeeId"].int ?? 0
                reactType = result[i]["reactType"].int ?? 0
                name = result[i]["name"].string ?? ""
                avatar = result[i]["avatar"].string ?? ""
                
                let tempCommentData = ReactData(id: id!, employeeId: employeeId!, reactType: reactType!, name: name!, avatar: avatar!)
                data.append(tempCommentData)
            }
            
            returnCallBack(data)
        })
    }
}
