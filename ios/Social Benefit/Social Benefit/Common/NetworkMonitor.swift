//
//  NetworkMonitor.swift
//  Social Benefit
//
//  Created by Admin on 11/8/21.
//

import Foundation
import Network
 
final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
     
    @Published var isNotConnected = false
     
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isNotConnected = path.status == .satisfied ? false : true
            }
        }
        monitor.start(queue: queue)
    }
}
