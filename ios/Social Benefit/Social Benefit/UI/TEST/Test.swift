import SwiftUI
import SwiftyJSON
import Alamofire

class curlApi {
    func call() {
//
//        // Prepare URL
//        let url = URL(string: "https://auth.sandbox.vuiapp.vn/auth/realms/nissho/protocol/openid-connect/token")
//        guard let requestUrl = url else { fatalError() }
//
//        // Prepare URL Request Object
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//
//        // Set HTTP Request Body
//        let params = ["client_id": "application-api", "grant_type": "client_credentials", "client_secret": "0a2dd6e3-ff6c-447a-ac14-c4dd61a3a1be"]
//        let jsonData = try? JSONEncoder().encode(params)
//
//        request.httpBody = jsonData
//
//        // Set HTTP Requst Header
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        // Perform HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                print("Call API failed: ", error?.localizedDescription ?? "No data")
//                return
//            }
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//
//                    print(json)
//
//                    let error = json["error_description"] as? Bool
//                    if (error == false) {
//                        let result = JSON(json as Any)["result"]
//                        print(result)
//                    } else {
//                        //show error
//                        if json["messages"] != nil {
//                            print("Call API failed, Messages: ", json["messages"]!)
////                            callback(JSON(["errors": json["messages"]]))
//                        }
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = ["client_id": "application-api", "grant_type": "client_credentials", "client_secret": "0a2dd6e3-ff6c-447a-ac14-c4dd61a3a1be"]
        
        let url = "https://auth.sandbox.vuiapp.vn/auth/realms/nissho/protocol/openid-connect/token"

        let task = AF.request(url, method: .post, parameters: parameters , headers: headers).responseDecodable { (response: AFDataResponse<JSON>) in
            switch response.result {
            case .success:
                print("Validation Successful")
                let result = JSON(response.data as Any)
                print(result)
                
            case let .failure(error):
                print("Call API failed, Messages: ", error)
            }
        }
        task.resume()
        
        
//        guard let url = URL(string: "https://auth.sandbox.vuiapp.vn/auth/realms/nissho/protocol/openid-connect/token"),
//            let payload = "{\"client_id\": \"application-api\", \"grant_type\": \"client_credentials\", \"client_secret\": \"0a2dd6e3-ff6c-447a-ac14-c4dd61a3a1be\"}".data(using: .utf8) else
//        {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpBody = payload
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard error == nil else { print(error!.localizedDescription); return }
//            guard let data = data else { print("Empty data"); return }
//
//            if let str = String(data: data, encoding: .utf8) {
//                print(str)
//            }
//        }.resume()
    }
}






