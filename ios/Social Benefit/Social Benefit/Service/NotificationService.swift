//
//  NotificationService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 11/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class NotificationService {
    
    func getAPI(items: [NotificationItemData], returnCallBack: @escaping () -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "companyId": userInfor.companyId,
                      "employeeId": userInfor.employeeId]
        
        var simpleItems = [NotificationItemDataNil]()
        
        for item in items {
            var tempItem = NotificationItemDataNil()
            
            tempItem.setType(type: item.getType())
            tempItem.setTypeId(typeId: item.getTypeId())
            
            simpleItems.append(tempItem)
        }
        
        let simpleItemsJsonData = try! JSONEncoder().encode(simpleItems)
        let json = String(data: simpleItemsJsonData, encoding: String.Encoding.utf8)
        
        let params: Parameters = ["items": json ?? ""]
        
        service.makeCall(endpoint: Config.API_NOTIFICATION_READ, method: "POST", header: header as [String: String], body: params, callback: { result in

        })
    }
}
