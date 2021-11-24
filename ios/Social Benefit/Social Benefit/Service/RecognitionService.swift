//
//  RecognitionService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class RecognitionService {
    
    func getListCompany(fromIndex: Int, returnCallBack: @escaping ([RecognitionData]) -> ()) {
        let service = BaseAPI()
        var data = [RecognitionData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["fromIndex": fromIndex]

        service.makeCall(endpoint: Config.API_RECOGNITION_LIST_BY_COMPANY, method: "POST", header: header, body: params, callback: { (result) in
            
            for i in 0..<result.count {
                let id = result[i]["id"].int ?? -1
                let createdTime = result[i]["createdTime"].int ?? 0
                let from = result[i]["from"].string ?? ""
                let to = result[i]["to"].string ?? ""
                let message = result[i]["message"].string ?? ""
                let point = result[i]["point"].int ?? 0
                
                // React, comment
                let myReact = result[i]["myReact"].int ?? 0
                let reactTop1 = result[i]["reactTop1"].int ?? 0
                let reactTop2 = result[i]["reactTop2"].int ?? 0
                let totalOtherReact = result[i]["totalOtherReact"].int ?? 0
                let commentCount = result[i]["commentCount"].int ?? 0
                
                
                let tempDate = getDateElementSince1970(createdTime)
                let createDateFomat = Date(timeIntervalSince1970: Double(createdTime / 1000))
                
                let date = String(format: "%02d/%02d/%d", tempDate.day ?? 0, tempDate.month ?? 0, tempDate.year ?? 0)
                let time = String(format: "%02d:%02d", tempDate.hour ?? 0, tempDate.minute ?? 0)
            
                let temp = RecognitionData(id: id, createdTime: createDateFomat, time: time, date: date, from: from, to: to, message: message, point: point, myReact: myReact, reactTop1: reactTop1, reactTop2: reactTop2, totalOtherReact: totalOtherReact, commentCount: commentCount)
                
                data.append(temp)
            }
            
            returnCallBack(data)
        })
    }
    
    func getTop3Recognition(returnCallBack: @escaping ([UserInfor]) -> ()) {
        let service = BaseAPI()
        var data = [UserInfor]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset": "0"]
        
        let params: Parameters = ["": ""]

        service.makeCall(endpoint: Config.API_RECOGNITION_TOP_RANK, method: "POST", header: header, body: params, callback: { (result) in
            let result = result["top3Recognition"]
            
            for i in 0..<result.count {
                let employeeDto = result[i]
                let citizen = result[i]["citizen"]
                
                data.append(UserInfor(employeeDto: employeeDto, citizen: citizen))
            }
            
            returnCallBack(data)
        })
    }
}

