//
//  FunctionCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 17/08/2021.
//

import SwiftUI
import StoreKit

struct FunctionCardView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var customerSupportViewModel: CustomerSupportViewModel
    
    var thumnail: String
    var thumailColor: Color
    var functionName: String
    var chevron: Bool
    var isPresentTabBar: Bool
    
    @Binding var selection: Int?
    @Binding var isRate: Bool
    
    var selectedNumber: Int
    var isCountClick = true
    
    var body: some View {
        ZStack {
            Button(action: {
                // Do something
                self.selection = selectedNumber
                self.homeScreenViewModel.isPresentedTabBar = isPresentTabBar
                if selectedNumber == 7 {
                    customerSupportViewModel.isPresentCustomerSupportPopUp = true
                    customerSupportViewModel.resetText()
                }
                
                // If click to Rate the app
                if selectedNumber == 8 {
//                    SKStoreReviewController.requestReview()
                    isRate = true
                }
                
                // Click count
                if isCountClick {
                    countClick()
                }
            }, label: {
                HStack {
                    Image(systemName: thumnail)
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(.leading, 10)
                        .foregroundColor(thumailColor)
                    
                    Text(functionName)
                        .foregroundColor(.black)
                    Spacer()
                    
                    if chevron {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .padding(.trailing, 10)
                    }
                }
                .frame(width: ScreenInfor().screenWidth - 22*2, height: 50, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
                .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
            })
        }
        
    }
    
}

struct FunctionCardView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionCardView(thumnail: "point_history".localized, thumailColor: Color.blue, functionName: "tt", chevron: true, isPresentTabBar: false, selection: .constant(1), isRate: .constant(true), selectedNumber: 1)
    }
}
