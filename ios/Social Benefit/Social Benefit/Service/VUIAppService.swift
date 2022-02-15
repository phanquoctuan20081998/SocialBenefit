//
//  VUIAppService.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class VUIAppService {
    
    func getAPI(token: String, url: String, employeeCode: String, phoneNumber: String, returnCallBack: @escaping (JSON) -> ()) {
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "{\r\n    \"employeeCode\": \"\(employeeCode)\",\r\n    \"phoneNumber\": \"\(phoneNumber)\"\r\n}"
//        let parameters = "{\r\n    \"employeeCode\": \"OSD200720PQ\",\r\n    \"phoneNumber\": \"0902723383\"\r\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Call API failed: ", error?.localizedDescription ?? "No data")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let result = JSON(json as Any)
                    returnCallBack(result)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
