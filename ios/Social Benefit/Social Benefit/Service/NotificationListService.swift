//
//  NotificationListService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON 

class NotificationListService {
    
    func getAPI(nextPageIndex: Int, pageSize: Int, returnCallBack: @escaping ([NotificationItemData]) -> ()) {
        let service = BaseAPI()
        var data = [NotificationItemData]()
        
        let header = ["token": userInfor.token,
                      "companyId": userInfor.companyId,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["range": "[\(nextPageIndex), \(pageSize)]"]
        
        var id: Int = -1
        var imgURL: String = ""
        var typeId: Int = -1
        var type: Int = -1
        var content: String = ""
        var createdTime: Int = 0
        var status: Int = -1
        var contentParams: [String] = []
        var receivedId: Int = -1
        var point: Int = -1
        
        service.makeCall(endpoint: Config.API_NOTIFICATION_LIST, method: "POST", header: header as [String: String], body: params, callback: { result in
   
            for i in 0..<result.count {
                
                id = result[i]["id"].int ?? -1
                imgURL = result[i]["imageUrl"].string ?? ""
                typeId = result[i]["typeId"].int ?? -1
                type = result[i]["type"].int ?? -1
                content = result[i]["content"].string ?? ""
                createdTime = result[i]["createdDate"].int ?? 0
                status = result[i]["status"].int ?? 0
                contentParams = result[i]["contentParams"].arrayValue.map { $0.stringValue }
                receivedId = result[i]["receivedId"].int ?? 0
                point = result[i]["point"].int ?? 0
                
               
                let tempData = NotificationItemData(id: id, imgURL: imgURL, typeId: typeId, type: type, content: content, createdTime: createdTime, status: status, contentParams: contentParams, receivedId: receivedId, point: point)
                
                data.append(tempData)
            }
            returnCallBack(data)
        })
    }
}


