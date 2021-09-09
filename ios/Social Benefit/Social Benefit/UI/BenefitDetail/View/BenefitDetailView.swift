//
//  ConditionOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct BenefitDetailView: View {

    @Binding var isPresentedTabBar: Bool
    
    @State var isPresentedPopup: Bool = false
    @State var isApplied: Bool = false
    
    var selectedBenefit: BenefitData
    
    var body: some View {
        VStack {
            VStack {
                // Upper view...
                // Reference at ListOfBenefitsView.swift...
                BenefitUpperView(isPresentedTabBar: $isPresentedTabBar, isShowTabBar: false)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 2)
                Text(selectedBenefit.title)
                    .bold()
                    .font(.system(size: 20))
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
            }
            
            Spacer()
            
            VStack {
                ScrollView {
                    Text(selectedBenefit.body)
                        .font(.system(size: 15))
                        .padding()
                }
                
                if isApplied {
                    Text("waiting_to_conform".localized)
                        .bold()
                        .foregroundColor(.blue)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:10)
                                        .fill(Color.black.opacity(0.1))
                                        .frame(width: ScreenInfor().screenWidth * 0.7))
                        .padding()
                        
                    
                } else {
                    Button(action: {
                        self.isPresentedPopup = true
                    }, label: {
                        RoundedButton(text: "register_now".localized, font: .system(size: 20, weight: .bold, design: .default), backgroundColor: Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)), textColor: Color(#colorLiteral(red: 0.6202182174, green: 0.7264552712, blue: 0.9265476465, alpha: 1)), cornerRadius: 10)
                            .padding()
                    })
                }
            }
            let _ = print(selectedBenefit.logo)
        }.overlay(ApplyPopupView(isPresented: $isPresentedPopup, isApplied: $isApplied, benefitId: selectedBenefit.id))
    }
}

struct ConditionOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitDetailView(isPresentedTabBar: .constant(false), selectedBenefit: BenefitData(id: 368, title: "Testjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobile", body: "Testjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobileTestjcnsdjkncjkdsncjkdnscjknsdjkcndsjk mobile", logo: "", typeMember: 2, status: 2, mobileStatus: 0))
    }
}
