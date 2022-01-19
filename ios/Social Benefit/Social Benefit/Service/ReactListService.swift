//
//  ReactListService.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation
import Alamofire

class ReactListService: APIServiceProtocol {
    let apiRequest = APIRequest()
    
    func request(contentType: Int?, contentId: Int?, reactType: Int?, fromIndex: Int, completion: @escaping (Result<ReactListModel, AppError>) -> Void) {
        
        let header: HTTPHeaders = [
            "token": userInfor.token,
            "employeeId": userInfor.employeeId,
            "companyId": userInfor.companyId
        ]
        
        let body = ReactListRequestModel.init(reactType: reactType, contentType: contentType, contentId: contentId, fromIndex: fromIndex)
    
        apiRequest.request(url: Config.API_GET_REACT_LIST, method: .post, headers: header, httpBody: body, type: ReactListModel.self) { response in
            completion(response)
        }
    }
}
