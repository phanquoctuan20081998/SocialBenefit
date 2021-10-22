//
//  TrimStringWithNChar.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 21/10/2021.
//

import Foundation

func trimStringWithNChar(_ number: Int, string: String) -> String {
    if string.count > number {
        return String(string.prefix(number))
    }
    
    return string
}
