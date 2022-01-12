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

class NotificationCountService {
    
    func getAPI(returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
//        var data = [NotificationItemData]()
        
        let header = ["token": userInfor.token,
                      "companyId": userInfor.companyId,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_NOTIFICATION_TOTAL, method: "POST", header: header as [String: String], body: params, callback: { result in
            
            let total = result["total"].int ?? 0
            
            returnCallBack(total)
        })
    }
}


