//
//   UsedPointsHistory.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/11/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class UsedPointHistoryService {
    
    func getAPI(pointActionType: Int, searchPattern: String, fromIndex: Int, returnCallBack: @escaping ([UsedPointsHistoryData]) -> ()) {
        let service = BaseAPI()
        var data = [UsedPointsHistoryData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["pointActionType": pointActionType,
                                  "searchPattern": searchPattern,
                                  "fromIndex": fromIndex]

        service.makeCall(endpoint: Config.API_USED_POINTS_HISTORY_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            for i in 0..<result.count {
                let id = result[i]["id"].int ?? -1
                let mAction = result[i]["mAction"].int ?? -1
                let mDestination = result[i]["mDestination"].string ?? ""
                let mPoint = result[i]["mPoint"].int ?? 0
                
                let issueTime = result[i]["issueTime"].int ?? 0
                let date = getDateElementSince1970(date: issueTime)
                let mDate = convertToEnglishFormat(day: date.day, month: date.month, year: date.year)
                let mTime = String(format: "%02d:%02d", date.hour ?? 0, date.minute ?? 0)
            
                let temp = UsedPointsHistoryData(id: id, mDate: mDate, mTime: mTime, mAction: mAction, mDestination: mDestination, mPoint: mPoint)
                
                data.append(temp)
            }
            
            returnCallBack(data)
        })
    }
}
