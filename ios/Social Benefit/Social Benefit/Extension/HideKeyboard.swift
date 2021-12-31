//
//  HideKeyboard.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 31/12/2021.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
