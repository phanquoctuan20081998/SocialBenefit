//
//  RequestModelProtocol.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import Foundation

protocol APIModelProtocol: Codable {
    var json: String { get }
    var data: Data? { get }
}

extension APIModelProtocol {
    var data: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    var json: String {
        if let data = data, let json = String(data: data, encoding: .utf8) {
            return json
        }
        return ""
    }
}


protocol APIResponseProtocol: APIModelProtocol {
    var status: Int? { get set }
    var messages: [String]? { get set }
}

