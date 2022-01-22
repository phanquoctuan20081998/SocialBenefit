//
//  Med247.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 22/01/2022.
//

import UIKit
import SwiftUI
import MedLib

final class Med247ViewController: UIViewController {
    
    var MED247 = MerchantSpecialList()
    var MED247Setting: [MerchantSpecialSettings] = []
    var code: String = ""
    var secretKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MED247 = userInfor.merchantSpecialData.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.MED247 }) ?? MerchantSpecialList()
        MED247Setting = MED247.merchantSpecialSettings!
        code = MED247Setting[MED247Setting.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.COMPANY}) ?? 0].settingValue!
        secretKey = MED247Setting[MED247Setting.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.CODE}) ?? 0].settingValue!
        
        MedKit.shared.present(rootVC: self, code: code, secretKey: secretKey, env: MedEnv.STAG) { error in
            
        }
    }
}
