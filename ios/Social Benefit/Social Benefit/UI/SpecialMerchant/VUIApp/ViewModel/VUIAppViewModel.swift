//
//  VUIAppView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation
import Combine

class VUIAppViewModel: ObservableObject, Identifiable {
    
    @Published var authUrl: String = ""
    @Published var apiUrl: String = ""
    @Published var clientId: String = userInfor.clientId
    @Published var clientSecret: String = userInfor.clientSecret

    @Published var isLoading: Bool = false
    @Published var isCannotConnectToServer: Bool = false
    
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
        
        self.isLoading = true
        
        merchantSpecialSettingsService.getAPI(code: Constants.MerchantSpecialCode.VUI) { data in
            self.authUrl = data[Constants.MerchantSpecialSettings.AUTH_URL].string ?? ""
            self.apiUrl = data[Constants.MerchantSpecialSettings.API_URL].string ?? ""
            
            self.getOAth2()
        }
    }
    
    func getOAth2() {
        if !self.authUrl.isEmpty
            && !self.apiUrl.isEmpty
            && !self.clientId.isEmpty
            && !self.clientSecret.isEmpty {
            oath2Service.getAPI(url: authUrl, clientId: userInfor.clientId, clientSercet: userInfor.clientSecret) { data in
                
                self.isLoading = false
            }
        }
    }
   
}
