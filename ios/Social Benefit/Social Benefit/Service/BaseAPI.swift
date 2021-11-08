//
//  BaseAPI.swift
//  Social Benefit
//
//  Created by Admin on 7/14/21.
//

import Foundation
import Alamofire
import SwiftyJSON

// TO CONTROL SESSION EXPIRED
public class SessionController: ObservableObject {
    static let shared = SessionController()
    init()  { }
    
    @Published var isExpried = false
    @Published var isFailConnectToServer = false
}

var sessionController = SessionController.shared


// Call API using URLSession
public class BaseAPI {
    private var session: URLSession
    var sessionController: SessionController
    
    public init() {
        session = URLSession.shared
        sessionController = SessionController.shared
    }
    
    public func makeCall(endpoint: String, method: String, header: [String : String], body: [String: Any], callback: @escaping (JSON) -> Void) {
        
        var isSuccessed = false
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        let url = URL(string: Config.baseURL +  endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        if header != ["":""] {request.allHTTPHeaderFields = header}
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            isSuccessed = true
            
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
                            callback(JSON())
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                
                // When session expired
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        if(401...402).contains(httpResponse.statusCode) {
                            self.sessionController.isExpried = true
                        }
                    }
                }
            }
        }
        
        // When cannot connect to server
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.MAX_API_LOAD_SECOND) {
            if !isSuccessed {
                self.sessionController.isFailConnectToServer = true
            }
        }
        
        task.resume()
    }
}


// Call API using Alamofire
public class BaseAPI_Alamofire {
    
    public func makeCall(endpoint: String, method: String, header: HTTPHeaders, body: Parameters, callback:@escaping (JSON)->Void) {
        let strURL = Config.baseURL + endpoint
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
