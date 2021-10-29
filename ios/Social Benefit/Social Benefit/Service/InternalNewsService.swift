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
    
    func getAPI(returnCallBack: @escaping ([InternalNewsData]) -> ()) {
        let service = BaseAPI_Alamofire()
        var data = [InternalNewsData]()
        
        let pageNum = 100
        let companyId = userInfor.companyId
        
        // ApprovalStatus...
        // 1: Pending
        // 2: Approved
        // 3: Rejected
        // 4: Draft
        
        let filter = "{\"companyId\":\"" + companyId + "\",\"approvalStatus\":\"2\"}"
        
        var order: Int = 0
        
        let header: HTTPHeaders = ["token": userInfor.token]
        let params: Parameters = ["page" : 0,
                                  "size" : pageNum,
                                  "filter" : filter]
        
        var contentId: Int?
        var title: String?
        var shortBody: String?
        var body: String?
        var cover: String?
        var newsCategory: Int?
        
        service.makeCall(endpoint: Config.API_INTERNAL_NEWS_LIST, method: "GET", header: header, body: params, callback: { result in
            
            print(result)
            
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
    




