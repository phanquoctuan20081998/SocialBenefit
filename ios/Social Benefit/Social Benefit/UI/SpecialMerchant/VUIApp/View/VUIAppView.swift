//
//  VUIAppView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import SwiftUI

struct VUIAppView: View {
    
    @ObservedObject var vuiAppViewModel = VUIAppViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Text("")
                .onAppear {
                    vuiAppViewModel.loadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            
            MerchantLoadingView(merchantName: "VUI-NANO")
        }.navigationBarHidden(true)
    }
}

struct VUIAppView_Previews: PreviewProvider {
    static var previews: some View {
        VUIAppView()
    }
}
