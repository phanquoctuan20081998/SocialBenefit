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
        let service = BaseAPI_Alamofire(baseURL: url)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = ["client_id": "application-api",
                          "grant_type": "client_credentials",
                          "client_secret": "0a2dd6e3-ff6c-447a-ac14-c4dd61a3a1be"]
    
        var oath2Response = OAth2Response()
        
        service.makeCall(endpoint: "", method: "POST", header: headers, body: parameters, callback: { (result) in
            oath2Response.setScope(scope: result["scope"].string ?? "")
            oath2Response.setExpiresIn(expiresIn: result["expires_in"].int ?? 0)
            oath2Response.setTokenType(tokenType: result["token_type"].string ?? "")
            oath2Response.setAccessToken(accessToken: result["access_token"].string ?? "")
            oath2Response.setRefreshExpiresIn(refreshExpiresIn: result["refresh_expires_in"].int ?? 0)
            oath2Response.setNotBeforePolicy(notBeforePolicy: result["not-before-policy"].int ?? 0)
            
            returnCallBack(oath2Response)
        })
    }
}

