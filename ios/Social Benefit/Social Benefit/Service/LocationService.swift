//
//  LocationService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import Foundation
import Alamofire

class LocationService {
    
    func getAPI(_ id: String, returnCallBack: @escaping ([LocationData]) -> ()) {
        
        let service = BaseAPI_Alamofire()
        var data = [LocationData]()
        
        let filter: String
        
        if id == "" {
            filter = "{\"parent_id\":null}"
        } else {
            filter = "{\"parent_id\":\"" + id + "\"}"
        }
        
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "user_id": userInfor.userId]
        
        let params: Parameters = ["filter" : filter]
        
        var cityName: String?
        var cityId: String?
        
        service.makeCall(endpoint: Config.API_LOCATION_LIST, method: "POST", header: header, body: params, callback: { result in
            for i in 0..<result.count {
                cityName = result[i]["name"].string
                cityId = result[i]["id"].string
                
                let tempLocationData = LocationData(name: cityName!, id: cityId!)
                data.append(tempLocationData)
            }
            returnCallBack(data)
        })
        
    }
}
