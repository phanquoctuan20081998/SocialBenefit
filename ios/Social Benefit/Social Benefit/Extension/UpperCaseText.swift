//
//  UpperCaseText.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import Foundation

extension String {
    func toUpperCase() -> String {
        return localize.uppercased(with: .current)
    }
    private var localize : String {
        return NSLocalizedString( self, comment:"")
    }
}

