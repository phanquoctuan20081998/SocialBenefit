//
//  BaseAPI.swift
//  Social Benefit
//
//  Created by Admin on 7/14/21.
//

import Foundation
import Alamofire
import SwiftyJSON

// Call API using URLSession
public class BaseAPI {
    private var session: URLSession
    
    public init() {
        session = URLSession.shared
    }
    
    public func makeCall(endpoint: String, method: String, header: [String : String], body: [String: Any], callback: @escaping (JSON) -> Void) {
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        let url = URL(string: Constant.baseURL +  endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        if header != ["":""] {request.allHTTPHeaderFields = header}
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Call API failed:  ",error?.localizedDescription ?? "No data")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let error = json["error"] as? Bool
                    if (error == false) {
                        let result = JSON(json as Any)["result"]
                        callback(result)
                    } else {
                        //show error
                        if json["messages"] != nil {
                            print("Call API failed, Messages: ", json["messages"]!)
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}


// Call API using Alamofire
public class BaseAPI_Alamofire {
    
    public func makeCall(endpoint: String, method: String, header: HTTPHeaders, body: Parameters, callback:@escaping (JSON)->Void) {
        let strURL = Constant.baseURL + endpoint
        let METHOD: HTTPMethod
        
        switch method {
        case "POST":
            METHOD = .post
        case "GET":
            METHOD = .get
        default:
            METHOD = .post
        }
        
        let task = AF.request(strURL, method: METHOD, parameters: body, headers: header).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let result = JSON(response.data as Any)["result"]
                callback(result)
                
            case let .failure(error):
                print("Call API failed, Messages: ", error)
            }
        }
        task.resume()
        
    }
}
