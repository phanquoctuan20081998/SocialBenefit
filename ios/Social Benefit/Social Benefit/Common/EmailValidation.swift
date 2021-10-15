//
//  EmailValidation.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/10/2021.
//

import Foundation

func textFieldValidatorEmail(_ string: String) -> Bool {
    if string.count > 80 {
        return false
    }
    
    let emailFormat = "^[a-zA-Z0-9]([\\.])?[a-zA-Z0-9_.+-]+\\@([_a-zA-Z0-9-]+)(([\\.])([a-zA-Z]){2,3}+)+$"
    
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: string)
}
