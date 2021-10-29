//
//  CustomerSupportService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 08/10/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class CustomerSupportService {
    
    func getAPI(screen: String, content: String, returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["screen": screen,
                                  "content": content]

        service.makeCall(endpoint: Config.API_SEND_MAIL_CUSTOMER_SUPPORT, method: "POST", header: header, body: params, callback: { result in
            returnCallBack(result["id"].int ?? -1)
        })
    }
}
