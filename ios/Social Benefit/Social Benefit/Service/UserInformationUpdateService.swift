//
//  UserInformationUpdateService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/10/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class UserInformationService {
    
    func sendImageAPI(id: String, nickName: String, address: String, citizenId: String, email: String, phone: String, birthday: String, locationId: String, image: UIImage, imageName: String, returnCallBack: @escaping (JSON) -> ()) {
        
        let URLName = Config.baseURL + Config.API_EMPLOYEE_INFO_UPDATE
        
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data",
                                    "Content-Disposition" : "form-data",
                                    "token": userInfor.token,
                                    "companyId": userInfor.companyId]
        
        let params: Parameters = ["id": id,
                                  "nickName": nickName,
                                  "address": address,
                                  "citizenId": citizenId,
                                  "email": email,
                                  "phone": phone,
                                  "birthday": birthday,
                                  "locationId": locationId]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in params {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            guard let imgData = image.jpegData(compressionQuality: 1) else { return }
            multipartFormData.append(imgData, withName: "file", fileName: imageName + ".jpeg", mimeType: "image/jpeg")
            
            
            
        },to: URL.init(string: URLName)!, usingThreshold: UInt64.init(),
                  method: .post,
                  headers: headers).response { response in
            
            if (response.error == nil) {
                do {
                    if let jsonData = response.data{
                        let parsedData = JSON(jsonData as Any)["result"]
                        returnCallBack(parsedData)
                        
                    } else {
                        print("error message")
                        returnCallBack(JSON())
                    }
                }
                
            } else {
                print(response.error!.localizedDescription)
                returnCallBack(JSON())
            }
        }
    }
    
    func getAPI(id: String, nickName: String, address: String, citizenId: String, email: String, phone: String, birthday: String, locationId: String, returnCallBack: @escaping (Bool) -> ()) {
        
        // Trim white space...
        let nickName = nickName.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = address.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let service = BaseAPI_Alamofire()
        
        let header: HTTPHeaders = ["token": userInfor.token,
                                   "companyId": userInfor.companyId]
        
        let params: Parameters = ["id": id,
                                  "nickName": nickName,
                                  "address": address,
                                  "citizenId": citizenId,
                                  "email": email,
                                  "phone": phone,
                                  "birthday": birthday,
                                  "locationId": locationId]
        
        service.makeCall(endpoint: Config.API_EMPLOYEE_INFO_UPDATE, method: "POST", header: header, body: params, callback: { (result) in
            if result.isEmpty {
                returnCallBack(false)
            } else {
                returnCallBack(true)
            }
        })
    }
}