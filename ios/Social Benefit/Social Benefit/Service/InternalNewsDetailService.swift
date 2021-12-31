//
//  NewsDetailService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class InternalNewsDetailService {
    
    func getAPI(internalNewsId: Int, returnCallBack: @escaping (InternalNewsData) -> ()) {
        let service = BaseAPI_Alamofire()
    
        let endPoint = Config.API_INTERNAL_NEWS_GET + "/\(internalNewsId)"
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "user_id": userInfor.employeeId,
                                   "companyId": userInfor.companyId,
                                   "timezoneOffset": "0"]
        
        let params: Parameters = ["":""]

        service.makeCall(endpoint: endPoint, method: "GET", header: header, body: params, callback: { result in
            
            let contentId = result["contentId"].int ?? -1
            let title = result["title"].string ?? ""
            let shortBody = result["shortBody"].string ?? ""
            let body = result["body"].string ?? ""
            let cover = result["cover"].string ?? ""
            let newsCategory = result["newsCategory"].int ?? -1

               
            let data = InternalNewsData(id: contentId, contentId: contentId, title: title, shortBody: shortBody, body: body, cover: cover, newsCategory: newsCategory)
                   
            returnCallBack(data)
        })
    }
}
