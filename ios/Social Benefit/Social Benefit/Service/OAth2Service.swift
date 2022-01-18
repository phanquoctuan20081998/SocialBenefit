//
//  OAth2Service.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class OAth2Service {
    
    func getAPI(url: String, clientId: String, clientSercet: String, returnCallBack: @escaping (OAth2Response) -> ()) {
        let service = BaseAPI(baseURL: url)
        
        let header = ["": ""]
        
        
        let params: Parameters = ["client_id": clientId,
                                  "client_secret": clientSercet,
                                  "giant_type": "client_credentials"]
        
        service.makeCall(endpoint: "", method: "POST", header: header, body: params, callback: { (result) in
            
            print(result)
        })
    }
}

