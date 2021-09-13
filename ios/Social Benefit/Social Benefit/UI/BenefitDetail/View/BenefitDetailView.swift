//
//  ConditionOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct BenefitDetailView: View {
    
    @Binding var isPresentedTabBar: Bool
    @ObservedObject var benefitDetailViewModel: BenefitDetailViewModel
    
    var body: some View {
        VStack {
            VStack {
                // Upper view...
                // Reference at ListOfBenefitsView.swift...
                BenefitUpperView(isPresentedTabBar: $isPresentedTabBar, text: "condition".localized, isShowTabBar: false)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 2)
                Text(self.benefitDetailViewModel.benefit.title)
                    .bold()
                    .font(.system(size: 20))
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
            }
            
            Spacer()
            
            VStack {
                ScrollView {
                    Text(self.benefitDetailViewModel.benefit.body)
                        .font(.system(size: 15))
                        .padding()
                }
                getApplyButton()
            }
        }.overlay(ApplyPopupView())
        .environmentObject(benefitDetailViewModel)
    }
    
    @ViewBuilder
    func getApplyButton() -> some View {
        
        switch self.benefitDetailViewModel.applyStatus {
        
        case 0:
            applyButtonView(text: "waiting_to_confirm".localized, textColor: Color(#colorLiteral(red: 0.2712115049, green: 0.5014922023, blue: 0.91060853, alpha: 1)), backgroundColor: Color(#colorLiteral(red: 0.9607003331, green: 0.9608382583, blue: 0.9606701732, alpha: 1)), disable: true)
        case 1:
            applyButtonView(text: "approved".localized, textColor: Color(#colorLiteral(red: 0.2712115049, green: 0.5014922023, blue: 0.91060853, alpha: 1)), backgroundColor: Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)), disable: false)
        case 2:
            applyButtonView(text: "rejected".localized, textColor: Color(#colorLiteral(red: 0.2712115049, green: 0.5014922023, blue: 0.91060853, alpha: 1)), backgroundColor: Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)), disable: false)
        case 3:
            applyButtonView(text: "recieved".localized, textColor: Color(#colorLiteral(red: 0.2712115049, green: 0.5014922023, blue: 0.91060853, alpha: 1)), backgroundColor: Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)), disable: false)
        default: do {
            // Check member type...
            if self.benefitDetailViewModel.benefit.typeMember == MEMBER_TYPE().BENEFIT_TYPE_REGISTER_MEMBER {
                applyButtonView(text: "register_now".localized, textColor: Color(#colorLiteral(red: 0.2712115049, green: 0.5014922023, blue: 0.91060853, alpha: 1)), backgroundColor: Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)), disable: false)
            }
        }
        }
    }
    
    func applyButtonView(text: String, textColor: Color, backgroundColor: Color, disable: Bool) -> some View {
        Button(action: {
            self.benefitDetailViewModel.isPresentedPopup = true
        }, label: {
            Text(text)
                .foregroundColor(textColor)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: ScreenInfor().screenWidth * 0.8)
                .padding(.vertical, 15)
                .background(backgroundColor)
                .cornerRadius(10)
                .if(!disable) {view in
                    view.shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
        })
        .disabled(disable)
    }
}

struct ConditionOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitDetailView(isPresentedTabBar: .constant(false), benefitDetailViewModel: BenefitDetailViewModel(benefit: BenefitData(id: 0, title: "", body: "", logo: "", typeMember: 2, status: 1, mobileStatus: 1)))
    }
}
