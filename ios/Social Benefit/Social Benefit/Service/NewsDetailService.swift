//
//  NewsDetailService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 04/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class NewsDetailService {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func getAPI(returnCallBack: @escaping (InternalNewsData) -> ()) {
        let service = BaseAPI_Alamofire()
    
        let endPoint = Config.API_INTERNAL_NEWS_GET + "/\(self.id)"
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "user_id" : userInfor.employeeId,
                                   "companyId": userInfor.companyId,
                                   "timezoneOffset": "0"]
        
        let params: Parameters = ["":""]

        service.makeCall(endpoint: endPoint, method: "GET", header: header, body: params, callback: { result in
            
            print(result)
            
            let id = result["id"].int ?? -1
            let contentId = result["contentId"].int ?? -1
            let title = result["title"].string ?? ""
            let shortBody = result["shortBody"].string ?? ""
            let body = result["body"].string ?? ""
            let cover = result["cover"].string ?? ""
            let newsCategory = result["newsCategory"].int ?? -1
               
            let data = InternalNewsData(id: id, contentId: contentId, title: title, shortBody: shortBody, body: body, cover: cover, newsCategory: newsCategory)
                   
            returnCallBack(data)
        })
    }
}
