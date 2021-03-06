//
//  BaseAPI.swift
//  Social Benefit
//
//  Created by Admin on 7/14/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import Combine

// TO CONTROL SESSION EXPIRED
public class SessionExpired: ObservableObject {
    static let shared = SessionExpired()

    @Published var isExpried = false
    @Published var isLogin = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init()  {
        $isExpried
            .sink(receiveValue: loadIsLogin(isExpried:))
            .store(in: &cancellables)
    }
    
    func loadIsLogin(isExpried: Bool) {
        if isExpried {
            DispatchQueue.main.async {
                self.isLogin = false
            }
        }
    }
}

public class SessionTimeOut: ObservableObject {
    static let shared = SessionTimeOut()
    init()  { }
    
    @Published var isTimeOut = false
}
//
//var sessionExpired = SessionExpired.shared
//var sessionTimeOut = SessionTimeOut.shared


// Call API using URLSession
public class BaseAPI {
    private var session: URLSession
    var sessionExpired: SessionExpired
    var sessionTimeOut: SessionTimeOut
    var baseURL: String = Config.baseURL
    
    public init() {
        session = URLSession.shared
        sessionExpired = SessionExpired.shared
        sessionTimeOut = SessionTimeOut.shared
    }
    
    public init(baseURL: String) {
        session = URLSession.shared
        sessionExpired = SessionExpired.shared
        sessionTimeOut = SessionTimeOut.shared
        
        self.baseURL = baseURL
    }
    
    
    public func makeCall(endpoint: String, method: String, header: [String : String], body: [String: Any], callback: @escaping (JSON) -> Void) {
        
        var isSuccessed = false
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        let url = URL(string: self.baseURL +  endpoint)!
        var request = URLRequest(url: url)

        request.httpMethod = method
        if header != ["":""] {request.allHTTPHeaderFields = header}
        
        if endpoint.isEmpty && self.baseURL != Config.baseURL  {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        } else {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            isSuccessed = true
            
            guard let data = data, error == nil else {
                print("Call API failed: ", error?.localizedDescription ?? "No data")
               
                if (error?.localizedDescription == "Could not connect to the server.") {
                    DispatchQueue.main.async {
                        self.sessionTimeOut.isTimeOut = true
                    }
                }
                
                callback(JSON(["errors": error?.localizedDescription]))
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
                            print(endpoint)
                            print("Call API failed, Messages: ", json["messages"]!)
                            callback(JSON(["errors": json["messages"]]))
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
                
                // When session expired
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        if(401...402).contains(httpResponse.statusCode) {
                            self.sessionExpired.isExpried = true
                        }
                    } else if (error.localizedDescription == "Could not connect to the server.") {
                        self.sessionTimeOut.isTimeOut = true
                    }
                }
            }
        }
        
        // When cannot connect to server
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.MAX_API_LOAD_SECOND) {
            if !isSuccessed {
                self.sessionTimeOut.isTimeOut = true
            }
        }
        
        task.resume()
    }
}


// Call API using Alamofire
public class BaseAPI_Alamofire {
    
    var baseURL: String = Config.baseURL
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    init() {

    }
    
    public func makeCall(endpoint: String, method: String, header: HTTPHeaders, body: Parameters, callback:@escaping (JSON)->Void) {
        let strURL = baseURL + endpoint
        let METHOD: HTTPMethod
        
        switch method {
        case "POST":
            METHOD = .post
        case "GET":
            METHOD = .get
        default:
            METHOD = .post
        }
        
        let task = AF.request(strURL, method: METHOD, parameters: body, headers: header)
            .responseDecodable { (response: AFDataResponse<JSON>) in
            switch response.result {
            case .success:
                var result = JSON()
                print("Validation Successful")
                
                if endpoint.isEmpty && self.baseURL != Config.baseURL {
                    result = JSON(response.data as Any)
                } else {
                    result = JSON(response.data as Any)["result"]
                }
                callback(result)
                
            case let .failure(error):
                print("Call API failed, Messages: ", error)
            }
        }
        task.resume()
        
    }
}
