//
//  AppError.swift
//  Social Benefit
//
//  Created by chu phuong dong on 10/12/2021.
//

import Foundation

enum AppError: Error, Equatable {
    case connection
    case http
    case data
    case custom(text: String)
    case unkown
    case session
    case none
    
    var text: String {
        switch self {
        case .connection:
            return "network_error".localized
        case .http:
            return "network_error".localized
        case .data:
            return "unkown_error".localized
        case .custom(let text):
            return text
        case .unkown:
            return "unkown_error".localized
        case .none:
            return ""
        case .session:
            return "session_expired".localized
        }
    }
}
