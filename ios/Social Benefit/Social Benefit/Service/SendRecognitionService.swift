//
//  SendRecognitionService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 08/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class SendRecognitionService {
    
    func getAPI(pointType: Int, walletInfor: WalletInforData, pointTransactions: [PointTransactionRequestData], returnCallBack: @escaping (WalletInforData, String) -> ()) {
        let service = BaseAPI() 

        let walletInfoJsonData = try! JSONEncoder().encode(walletInfor)
        let walletInfoJson = String(data: walletInfoJsonData, encoding: String.Encoding.utf8)
        
        let pointTransactionJsonData = try! JSONEncoder().encode(pointTransactions)
        let pointTransactionJson = String(data: pointTransactionJsonData, encoding: String.Encoding.utf8)
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["pointType": pointType,
                                  "walletInfoJson": walletInfoJson ?? "",
                                  "employeeReceiveListJson": pointTransactionJson ?? ""]
        
        var data = WalletInforData(companyPoint: 0, personalPoint: 0)
        var error = ""
        
        service.makeCall(endpoint: Config.API_RECOGNITION_SEND, method: "POST", header: header, body: params, callback: { (result) in
            let companyPoint = result["companyPoint"].int
            let personalPoint = result["personalPoint"].int
            
            if companyPoint == nil && personalPoint == nil {
                error = result["errors"][0].string ?? ""
            } else {
                data = WalletInforData(companyPoint: companyPoint ?? 0, personalPoint: personalPoint ?? 0)
            }
            
            returnCallBack(data, error)
        })
    }
}
