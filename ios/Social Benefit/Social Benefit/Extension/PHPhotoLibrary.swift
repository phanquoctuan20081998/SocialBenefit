//
//  PHPhotoLibrary.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/01/2022.
//

import Foundation
import Photos
import UIKit

public extension PHPhotoLibrary {
   
   static func execute(controller: UIViewController,
                       onAccessHasBeenGranted: @escaping () -> Void,
                       onAccessHasBeenDenied: (() -> Void)? = nil) {
      
      let onDeniedOrRestricted = onAccessHasBeenDenied ?? {
         let alert = UIAlertController(
            title: "We were unable to load your album groups. Sorry!",
            message: "You can enable access in Privacy Settings",
            preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
               UIApplication.shared.open(settingsURL)
            }
         }))
         DispatchQueue.main.async {
            controller.present(alert, animated: true)
         }
      }

      let status = PHPhotoLibrary.authorizationStatus()
       print(status)
      switch status {
      case .notDetermined:
         onNotDetermined(onDeniedOrRestricted, onAccessHasBeenGranted)
      case .denied, .restricted:
         onDeniedOrRestricted()
      case .authorized:
         onAccessHasBeenGranted()
      case .limited: do {
          
      }
      @unknown default:
         fatalError("PHPhotoLibrary::execute - \"Unknown case\"")
      }
   }
   
}

private func onNotDetermined(_ onDeniedOrRestricted: @escaping (()->Void), _ onAuthorized: @escaping (()->Void)) {
   PHPhotoLibrary.requestAuthorization({ status in
       print(status)
      switch status {
      case .notDetermined:
         onNotDetermined(onDeniedOrRestricted, onAuthorized)
      case .denied, .restricted:
         onDeniedOrRestricted()
      case .authorized:
         onAuthorized()
      case .limited: do {
          
      }
      @unknown default:
         fatalError("PHPhotoLibrary::execute - \"Unknown case\"")
      }
   })
}
