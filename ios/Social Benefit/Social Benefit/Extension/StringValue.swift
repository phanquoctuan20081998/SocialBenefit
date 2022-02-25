//
//  StringValue.swift
//  Social Benefit
//
//  Created by chu phuong dong on 29/11/2021.
//

import Foundation

protocol StringValue {
    var string: String { get}
}

extension Int: StringValue {
    var string: String {
        return String(self)
    }
    
    var boolValue: Bool {
        return self != 0
    }
}

extension Float: StringValue {
    var string: String {
        return String(self)
    }
}

extension Double: StringValue {
    var string: String {
        return String(self)
    }
}

extension String: StringValue {
    var string: String {
        return self
    }
}
