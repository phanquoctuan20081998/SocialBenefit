//
//  GetInternalNewsData.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/08/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class InternalNewsService {
    
    func getAPI(fromIndex: Int, searchText: String, category: Int, pageSize: Int, returnCallBack: @escaping ([InternalNewsData]) -> ()) {
        let service = BaseAPI_Alamofire()
        var data = [InternalNewsData]()
        
        // 3 things should be consider: pageIndex, category, searchText...
        
        // 1 - pageIndex
        let page = fromIndex / pageSize
        
        // 2 - searchText
        var filterSearchText = ""
        
        if !searchText.isEmpty {
            filterSearchText = "\"title\":\"" + searchText + "\","
        }
        
        // 3 - category, sort
        let companyId = userInfor.companyId
        
        // ApprovalStatus...
        // 1: Pending
        // 2: Approved
        // 3: Rejected
        // 4: Draft
        
        let filter = "{\(filterSearchText)\"companyId\":\"\(companyId)\",\"approvalStatus\":\"2\", \"newsCategory\":\"\(category)\"}"
        let sort = "[\"postDate\",\"DESC\",\"approveRejectDate\",\"DESC\"]"
        
        // API
        var order: Int = 0
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "timezoneOffset": "\(Utils.millisecondsFromGMT / -60000)"]
        let params: Parameters = ["page" : page,
                                  "size" : pageSize,
                                  "filter" : filter,
                                  "sort": sort,
                                  "mobile": 1]
        
        var contentId: Int?
        var title: String?
        var shortBody: String?
        var body: String?
        var cover: String?
        var newsCategory: Int?
        
        service.makeCall(endpoint: Config.API_INTERNAL_NEWS_LIST, method: "GET", header: header, body: params, callback: { result in
            
            for i in 0..<result.count {
                contentId = result[i]["id"].int ?? 0
                title = result[i]["title"].string ?? ""
                shortBody = result[i]["shortBody"].string ?? ""
                body = result[i]["body"].string ?? ""
                cover = result[i]["cover"].string ?? ""
                newsCategory = result[i]["newsCategory"].int ?? 0
                
                let tempInternalNewsData = InternalNewsData(id: order, contentId: contentId!, title: title!, shortBody: shortBody!, body: body!, cover: cover!, newsCategory: newsCategory!)
                data.append(tempInternalNewsData)
                order += 1
            }
            
           returnCallBack(data)
            
        })
    }
}
