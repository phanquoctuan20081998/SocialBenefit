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
    
    // Recognition News Feed...
    func getListByCompany(fromIndex: Int, returnCallBack: @escaping ([RecognitionData]) -> ()) {
        let service = BaseAPI()
        var data = [RecognitionData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
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
    
    func getListByEmployee(employeeId: String, fromIndex: Int, onlyCurrentMonth: Bool, returnCallBack: @escaping ([RecognitionData]) -> ()) {
        let service = BaseAPI()
        var data = [RecognitionData]()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let params: Parameters = ["fromIndex": fromIndex,
                                  "employeeId": employeeId,
                                  "onlyCurrentMonth": onlyCurrentMonth]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_LIST_BY_EMPLOYEE, method: "POST", header: header, body: params, callback: { (result) in
            
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
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
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
    
    func getMyRank(returnCallBack: @escaping (Int) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_TOP_RANK, method: "POST", header: header, body: params, callback: { (result) in
            let myRank = result["myRank"].int ?? 0
            returnCallBack(myRank)
        })
    }
    
    // Ranking of Recognition...
    func getRankingList(fromIndex: Int, limit: Int, returnCallBack: @escaping ([RankingOfRecognitionData]) -> ()) {
        let service = BaseAPI()
        var data = [RankingOfRecognitionData]()
        let startRank = fromIndex + 1
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let params: Parameters = ["fromIndex": fromIndex,
                                  "limit": limit]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_RANKING_LIST, method: "POST", header: header, body: params, callback: { (result) in
            
            for i in 0..<result.count {
                let id = result[i]["id"].int ?? -1
                var rank = result[i]["rank"].int ?? 0
                let avatar = result[i]["avatar"].string ?? ""
                let employeeName = result[i]["employeeName"].string ?? ""
                let totalScore = result[i]["totalScore"].int ?? 0
                
                if rank == 0 {
                    rank = startRank + i
                }
                
                let temp = RankingOfRecognitionData(id: id, rank: rank, avatar: avatar, employeeName: employeeName, totalScore: totalScore)
                data.append(temp)
            }
            
            returnCallBack(data)
        })
    }
    
    func getMyRankDetail(returnCallBack: @escaping (RankingOfRecognitionData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId,
                      "timezoneOffset":  "\(Utils.millisecondsFromGMT / -60000)"]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_RANKING_EMPLOYEE_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            let id = result["id"].int ?? -1
            let rank = result["rank"].int ?? 0
            let avatar = result["avatar"].string ?? ""
            let employeeName = result["employeeName"].string ?? ""
            let totalScore = result["totalScore"].int ?? 0
            
            let data = RankingOfRecognitionData(id: id, rank: rank, avatar: avatar, employeeName: employeeName, totalScore: totalScore)
            
            returnCallBack(data)
        })
    }
    
    // Post Detail...
    func getPostDetail(id: Int, returnCallBack: @escaping (RecognitionDetailData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["id": id]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_DETAIL_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            let id = result["id"].int ?? 0
            let senderAvatar = result["senderAvatar"].string ?? ""
            let senderFullName = result["senderFullName"].string ?? ""
            let senderJobDescription = result["senderJobDescription"].string ?? ""
            let receiverAvatar = result["receiverAvatar"].string ?? ""
            let receiverFullName = result["receiverFullName"].string ?? ""
            let point = result["point"].int ?? 0
            let recognitionNote = result["recognitionNote"].string ?? ""
            let date = result["recognitionTime"].int ?? 0
            let recognitionTime = Date(timeIntervalSince1970: Double(date / 1000))
            
            let data = RecognitionDetailData(id: id, senderAvatar: senderAvatar, senderFullName: senderFullName, senderJobDescription: senderJobDescription, receiverAvatar: receiverAvatar, receiverFullName: receiverFullName, point: point, recognitionNote: recognitionNote, recognitionTime: recognitionTime)
            
            returnCallBack(data)
        })
    }
    
    func getPostReaction(id: Int, returnCallBack: @escaping (RecognitionData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["id": id]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_GET, method: "POST", header: header, body: params, callback: { (result) in

            let id = result["id"].int ?? -1
            let createdTime = result["createdTime"].int ?? 0
            let from = result["from"].string ?? ""
            let to = result["to"].string ?? ""
            let message = result["message"].string ?? ""
            let point = result["point"].int ?? 0
            
            // React, comment
            let myReact = result["myReact"].int ?? 0
            let reactTop1 = result["reactTop1"].int ?? 0
            let reactTop2 = result["reactTop2"].int ?? 0
            let totalOtherReact = result["totalOtherReact"].int ?? 0
            let commentCount = result["commentCount"].int ?? 0
            
            
            let tempDate = getDateElementSince1970(createdTime)
            let createDateFomat = Date(timeIntervalSince1970: Double(createdTime / 1000))
            
            let date = String(format: "%02d/%02d/%d", tempDate.day ?? 0, tempDate.month ?? 0, tempDate.year ?? 0)
            let time = String(format: "%02d:%02d", tempDate.hour ?? 0, tempDate.minute ?? 0)
            
            let data = RecognitionData(id: id, createdTime: createDateFomat, time: time, date: date, from: from, to: to, message: message, point: point, myReact: myReact, reactTop1: reactTop1, reactTop2: reactTop2, totalOtherReact: totalOtherReact, commentCount: commentCount)
            
            returnCallBack(data)
        })
    }
    
    func getEmployeeRank(employeeId: Int, returnCallBack: @escaping (RankingOfRecognitionData) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": "\(employeeId)",
                      "companyId": userInfor.companyId]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_RECOGNITION_RANKING_EMPLOYEE_GET, method: "POST", header: header, body: params, callback: { (result) in
            
            let id = result["id"].int ?? -1
            let rank = result["rank"].int ?? 0
            let avatar = result["avatar"].string ?? ""
            let employeeName = result["employeeName"].string ?? ""
            let totalScore = result["totalScore"].int ?? 0
            
            let data = RankingOfRecognitionData(id: id, rank: rank, avatar: avatar, employeeName: employeeName, totalScore: totalScore)
            
            returnCallBack(data)
        })
    }
}
