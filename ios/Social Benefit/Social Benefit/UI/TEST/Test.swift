import SwiftUI
import SwiftyJSON
import Alamofire

class curlApi {
    func call(token: String) {

        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\r\n    \"employeeCode\": \"OSD190401NMA\",\r\n    \"phoneNumber\": \"0968891852\"\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://api.sandbox.vuiapp.vn/v2/sessions")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}






