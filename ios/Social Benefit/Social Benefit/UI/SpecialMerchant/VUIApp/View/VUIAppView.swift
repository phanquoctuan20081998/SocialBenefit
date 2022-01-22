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
            if vuiAppViewModel.isLoading {
                MerchantLoadingView(merchantName: "VUI-NANO")
            } else if !vuiAppViewModel.vuiAppResponse.getWebUrl().isEmpty {
                MerchantWebView(isLoading: $vuiAppViewModel.isLoading, merchantSpecialCode: Constants.MerchantSpecialCode.VUI, url: vuiAppViewModel.vuiAppResponse.getWebUrl())
            }
            
            if vuiAppViewModel.isPresentError {
                ErrorMessageView(error: vuiAppViewModel.applicationCode, isPresentedError: $vuiAppViewModel.isPresentError)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

struct VUIAppView_Previews: PreviewProvider {
    static var previews: some View {
        VUIAppView()
    }
}
