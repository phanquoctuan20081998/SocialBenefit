//
//  VUIAppView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import SwiftUI

struct VUIAppView: View {
    
    @ObservedObject var vuiAppViewModel = VUIAppViewModel()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                vuiAppViewModel.loadData()
            }
    }
}

struct VUIAppView_Previews: PreviewProvider {
    static var previews: some View {
        VUIAppView()
    }
}
