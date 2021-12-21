//
//  GetLocalizableText.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/08/2021.
//

import Foundation

extension Bundle {
    static var bundle: Bundle!

    static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.getAppLanguage()
            let path = Bundle.main.path(forResource: appLang.rawValue, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    static func setLanguage(lang: AppLanguage) {
        UserDefaults.setAppLanguage(value: lang)
        let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
     
}

extension String {
    var localized: String  {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized, arguments: arguments)
    }
}

