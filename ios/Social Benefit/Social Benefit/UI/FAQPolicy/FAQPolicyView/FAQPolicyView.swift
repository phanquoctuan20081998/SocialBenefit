//
//  FAQPolicyView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import Foundation
import SwiftUI

struct FAQPolicyView: View {
    
    let docType: Constants.DocumentType
    
    @StateObject var faqPolicyViewModel = FAQPolicyViewModel()
                                                                            
    var body: some View {
        ZStack {
            BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: faqPolicyViewModel.getTitle(docType: docType), isHaveLogo: false)
            
            if faqPolicyViewModel.isLoading {
                LoadingPageView()
            } else {
                if !faqPolicyViewModel.content.isEmpty {
                    VStack {
                        Spacer().frame(height: ScreenInfor().screenHeight * 0.085)
                        Webview(dynamicHeight: .constant(0), htmlString: faqPolicyViewModel.content, font: 0)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: ScreenInfor().screenWidth * 0.9, height: ScreenInfor().screenHeight * 0.8, alignment: .bottom)
                            
                        Spacer()
                    }
                }
            }
        }
        .onAppear() {
            faqPolicyViewModel.loadData(docType: docType)
        }
        .errorPopup($faqPolicyViewModel.error)
        .navigationBarHidden(true)
    }
}
