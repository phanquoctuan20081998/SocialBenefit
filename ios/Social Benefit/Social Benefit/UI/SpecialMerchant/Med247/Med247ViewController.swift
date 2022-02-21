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
    
    weak var delegate: Med247ViewControllerDelegate?
    
    var MED247 = MerchantSpecialList()
    var MED247Setting: [MerchantSpecialSettings] = []
    var code: String = ""
    var secretKey = ""
    
    @IBOutlet private weak var loadingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        MED247 = userInfor.merchantSpecialData.first(where: { $0.merchantCode ==  Constants.MerchantSpecialCode.MED247 }) ?? MerchantSpecialList()
        MED247Setting = MED247.merchantSpecialSettings!
        code = MED247Setting[MED247Setting.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.COMPANY}) ?? 0].settingValue!
        secretKey = MED247Setting[MED247Setting.firstIndex(where: { $0.settingCode == Constants.MerchantSpecialSettings.CODE}) ?? 0].settingValue!
        
        MedKit.shared.present(rootVC: self, code: code, secretKey: secretKey, env: MedEnv.STAG) { error in
            
        }
        
        loadingLabel.text = "you_are_being_redirected".localizeWithFormat(arguments: "Med 247")
    }
    
    @IBAction private func clickBack() {
        delegate?.dissmissView()
    }
}


protocol Med247ViewControllerDelegate: AnyObject {
    func dissmissView()
}

