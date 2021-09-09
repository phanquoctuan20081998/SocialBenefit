//
//  ConditionOfBenefitService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON
    
class BenefitDetailService {
    
    @Published var allInternalNews: [InternalNewsData] = []
    
    init() {
        self.getAPI()
    }
    
    func getAPI() {
        let service = BaseAPI_Alamofire()
        var data = [InternalNewsData]()
        
        let pageNum = 100
        let companyId = userInfor.companyId
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
        
        service.makeCall(endpoint: Constant.API_INTERNEL_NEWS_LIST, method: "GET", header: header, body: params, callback: { result in
            
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
            
            DispatchQueue.main.async {
                self.allInternalNews = data
            }
        })
    }
}
    




