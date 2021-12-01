//
//  GetEmployeeInforService.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class EmployeeInforService {
    func getAPI(employeeId: Int, returnCallBack: @escaping (UserInfor) -> ()) {
        let service = BaseAPI()
        
        let header = ["token": userInfor.token]
        
        let params: Parameters = ["": ""]
        
        service.makeCall(endpoint: Config.API_EMPLOYEE_INFO + "/\(employeeId)", method: "POST", header: header, body: params, callback: { (result) in
            
            let data = UserInfor(employeeDto: result, citizen: result["citizen"])
            
            returnCallBack(data)
        })
    }
}
