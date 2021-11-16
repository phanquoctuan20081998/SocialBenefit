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
    
    func getAPI(pointActionType: Int, searchPattern: String, fromIndex: Int, returnCallBack: @escaping (UsedPointsHistoryData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["pointActionType": pointActionType,
                                  "searchPattern": searchPattern,
                                  "fromIndex": fromIndex]

        service.makeCall(endpoint: Config.API_USED_POINTS_HISTORY_GET, method: "POST", header: header, body: params, callback: { (result) in
            let id = result["id"].int ?? -1
            let mAction = result["mAction"].int ?? -1
            let mDestination = result["mDestination"].string ?? ""
            let mPoint = result["mPoint"].int ?? 0
            
            let issueTime = result["issueTime"].int ?? 0
            let date = getDateElementSince1970(date: issueTime)
            let mDate = convertToEnglishFormat(day: date.day, month: date.month, year: date.year)
            let mTime = String(format: "%02d:%02d", date.hour ?? 0, date.minute ?? 0)
        
            let data = UsedPointsHistoryData(id: id, mDate: mDate, mTime: mTime, mAction: mAction, mDestination: mDestination, mPoint: mPoint)
            
            returnCallBack(data)
        })
    }
}
