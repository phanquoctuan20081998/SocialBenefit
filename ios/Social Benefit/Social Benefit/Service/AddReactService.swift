//
//  AddReactService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 08/09/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

    
class AddReactService {
    
    func getAPI(contentId: Int, contentType: Int, reactType: Int) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token,
                      "employeeId": userInfor.employeeId,
                      "contentId": String(contentId),
                      "contentType": String(contentType),
                      "reactType": String(reactType)]
        
        let params: Parameters = ["":""]
        
        service.makeCall(endpoint: Config.API_CONTENT_REACT, method: "POST", header: header as [String : String], body: params, callback: { result in
            if(result["success"].bool!) {
                print("Successfully update react")
            }
        })
    }
}
