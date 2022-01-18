//
//  VUIAppView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation
import Combine

class VUIAppViewModel: ObservableObject, Identifiable {
    
    @Published var authUrl: String = "https://auth.sandbox.vuiapp.vn/auth/realms/nissho/protocol/openid-connect/token"
    @Published var apiUrl: String = "https://api.sandbox.vuiapp.vn/v2/sessions"
//    @Published var clientId: String = userInfor.clientId
//    @Published var clientSecret: String = userInfor.clientSecret
    @Published var clientId: String = "application-api"
    @Published var clientSecret: String = "0a2dd6e3-ff6c-447a-ac14-c4dd61a3a1be"
    
    private var cancellables = Set<AnyCancellable>()
    private var merchantSpecialSettingsService = MerchantSpecialSettingsService()
    private var oath2Service = OAth2Service()
    private var vuiAppService = VUIAppService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
    }
    
    func loadData() {
        self.getOAth2()
        
//        merchantSpecialSettingsService.getAPI(code: Constants.MerchantSpecialCode.VUI) { data in
//            self.authUrl = data[Constants.MerchantSpecialSettings.AUTH_URL].string ?? ""
//            self.apiUrl = data[Constants.MerchantSpecialSettings.API_URL].string ?? ""
//
//            self.getOAth2()
//        }
    }
    
    func getOAth2() {
        if !self.authUrl.isEmpty
            && !self.apiUrl.isEmpty
            && !self.clientId.isEmpty
            && !self.clientSecret.isEmpty {
            oath2Service.getAPI(url: authUrl, clientId: userInfor.clientId, clientSercet: userInfor.clientSecret) { data in
                
            }
        }
    }
   
}
