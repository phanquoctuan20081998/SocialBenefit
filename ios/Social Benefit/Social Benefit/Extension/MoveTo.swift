//
//  MoveTo.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/08/2021.
//

import UIKit

extension UIViewController {
  func moveTo(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: animated, completion: completion)
  }
}

