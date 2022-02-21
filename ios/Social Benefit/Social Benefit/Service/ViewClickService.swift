//
//  ViewClickService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class ViewClickService {
    
    func updateAPI(items: [ViewClickItemData]) {
        let service = BaseAPI()
        let viewClickItemJsonData = try! JSONEncoder().encode(items)
        let viewClickItemJson = String(data: viewClickItemJsonData, encoding: String.Encoding.utf8)
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId]
        
        let params: Parameters = ["items": viewClickItemJson ?? ""]
        
        service.makeCall(endpoint: Config.API_MOBILE_VIEW_CLICK, method: "POST", header: header, body: params, callback: { (result) in
            print(result)
        })
    }
}
