//
//  NetworkMonitor.swift
//  Social Benefit
//
//  Created by Admin on 11/8/21.
//

import Combine
import Network
import Foundation
import SystemConfiguration

final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isPresentPopUp = false
    @Published var isConnected = true
     
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
        
        $isConnected
            .sink(receiveValue: loadPopUp(isConnected:))
            .store(in: &cancellables)
    }
    
    func loadPopUp(isConnected: Bool) {
        if !isConnected {
            self.isPresentPopUp = true
        }
    }
}
