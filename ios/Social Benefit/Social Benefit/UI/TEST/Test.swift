//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI
import WebKit
import SDWebImageSwiftUI
import Alamofire



class Test {
    func callsendImageAPI(param: [String: Any], image: UIImage, imageName: String, imageKey: String, URlName: String, withblock:@escaping (_ response: AnyObject?)->Void){
        
        let headers: HTTPHeaders
        headers = [
                   "token": "vMiHnglcXPedBidkNFUYXvGVoCEzDLxfzklxeJQUemTgZgIEeLqcfUemxBjaTFpBXQnmLdNEEFFgrJqbfkIkrDxIscTexjHFLPEY",
                   "companyId": "69"]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            guard let imgData = image.jpegData(compressionQuality: 1) else { return }
            multipartFormData.append(imgData, withName: imageKey, fileName: imageName + ".jpeg", mimeType: "image/jpeg")
            
            
        },to: URL.init(string: URlName)!, usingThreshold: UInt64.init(),
                  method: .post,
                  headers: headers).response{ response in
            
            if((response.error == nil)){
                do {
                    if let jsonData = response.data{
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                        print(parsedData)
                        
                    } else {
                        print("error message")
                    }
                    
                } catch{
                    print("error message")
                }
                
            } else{
                print(response.error as Any)
            }
        }
    }
}

struct Test1: View {
    
    var test = Test()
    
    var body: some View {
        VStack {
            Button {
                let params: Parameters = ["id": "384",
                                          "nickName":"d",
                                          "address": "32",
                                          "citizenId": "215",
                                          "email": "oanhph@nissho-vn.com",
                                          "phone": "1234",
                                          "birthday": "02/08/1998",
                                          "locationId": "00040"]
                
                let image = UIImage(named: "phim1")!
                
                let URLName = Config.baseURL + Config.API_EMPLOYEE_INFO_UPDATE
                
                test.callsendImageAPI(param: params, image: image, imageName: "profile", imageKey: "file", URlName: URLName) { result in
  
                }
            } label: {
                Text("Click")
            }
        }
    }
}




