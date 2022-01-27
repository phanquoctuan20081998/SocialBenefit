//
//  FAQPolicyView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import Foundation
import SwiftUI

struct FAQPolicyView: View {
    
    @ObservedObject var faqPolicyViewModel: FAQPolicyViewModel
                                                                            
    var body: some View {
        ZStack {
            BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: faqPolicyViewModel.getTitle(), isHaveLogo: false)
            
            if !faqPolicyViewModel.content.isEmpty {
                VStack {
                    if faqPolicyViewModel.isLoading {
                        LoadingView()
                    } else {
                        VStack {
                            Spacer().frame(height: ScreenInfor().screenHeight * 0.085)
                            HTMLView(htmlString: faqPolicyViewModel.content)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: ScreenInfor().screenWidth * 0.9, height: ScreenInfor().screenHeight * 0.8, alignment: .bottom)
                            Spacer()
                        }
                    }
                }
            }
            
            // Error
            ErrorMessageView(error: faqPolicyViewModel.error, isPresentedError: $faqPolicyViewModel.isPresentError)
        }
        .navigationBarHidden(true)
    }
}
