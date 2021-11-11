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
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data",
                   "token": userInfor.token,
                   "companyId": userInfor.companyId]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            guard let imgData = image.jpegData(compressionQuality: 1) else { return }
            multipartFormData.append(imgData, withName: imageKey, fileName: imageName + ".jpeg", mimeType: "image/jpeg")
            
            
            
        },to: URL.init(string: URlName)!, usingThreshold: UInt64.init(),
                  method: .post,
                  headers: headers).response{ response in
            
            if((response.error != nil)){
                do{
                    if let jsonData = response.data{
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                        print(parsedData)
                        
                    } else {
                        print("error message")
                    }
                    
                }catch{
                    print("error message")
                }
                
            }else{
                print(response.error!.localizedDescription)
            }
        }
    }
}

struct Test1: View {
    
    var test = Test()
    
    var body: some View {
        VStack {
            Button {
                let params: Parameters = ["id": userInfor.employeeId,
                                          "nickName": userInfor.nickname,
                                          "address": userInfor.noStreet,
                                          "citizenId": userInfor.citizenId,
                                          "email": userInfor.email,
                                          "phone": userInfor.phone,
                                          "birthday": userInfor.birthday,
                                          "locationId": userInfor.locationId]
                
                let image = UIImage(named: "home_my_profile.jpg")!
                
                let URLName = Config.baseURL + Config.API_EMPLOYEE_INFO_UPDATE
                
                test.callsendImageAPI(param: params, image: image, imageName: "home_my_profile", imageKey: "file", URlName: URLName) { result in
                    print(result)
                }
            } label: {
                Text("Click")
            }
        }
    }
}




