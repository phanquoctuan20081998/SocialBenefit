//
//  WalletInforService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class WalletInforService {
    
    func getAPI(returnCallBack: @escaping (WalletInforData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_EMPLOYEE_WALLET_INFO_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            let companyPoint = result["companyPoint"].int ?? 0
            let personalPoint = result["companyPoint"].int ?? 0
            
            let data = WalletInforData(companyPoint: companyPoint, personalPoint: personalPoint)
            
            returnCallBack(data)
        })
    }
}
