//
//  ConditionOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct BenefitDetailView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var benefitDetailViewModel: BenefitDetailViewModel
    @EnvironmentObject var listOfBenefitsViewModel: ListOfBenefitsViewModel
    
    @State private var webViewHeight: CGFloat = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                
                Spacer().frame(height: 30)
                
                // Upper view...
                // Reference at ListOfBenefitsView.swift...
                BenefitUpperView(isRefreshing: $listOfBenefitsViewModel.isRefreshing, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, text: "condition".localized, isShowTabBar: false)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 200, height: 2)
                
                Text(self.benefitDetailViewModel.benefit.title)
                    .bold()
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
            }
            
            Spacer()
            
            VStack {
                
                if benefitDetailViewModel.isLoading {
                    LoadingPageView()
                } else {
                    HTMLView(htmlString: self.benefitDetailViewModel.benefit.body)
                        .padding(30)
                }
                
                getApplyButton()
                    .padding(.bottom, 20)
            }
        }
        .overlay(ApplyPopupView(reload: .constant(false), benefitId: benefitDetailViewModel.benefit.id, index: benefitDetailViewModel.index))
        .overlay(BenefitErrorPopUpView().environmentObject(listOfBenefitsViewModel))
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func getApplyButton() -> some View {
        if self.benefitDetailViewModel.typeMember == BenefitData.MEMBER_TYPE.BENEFIT_TYPE_REGISTER_MEMBER {
            switch self.benefitDetailViewModel.applyStatus {
                
            case 0:
                applyButtonView(text: "waiting_to_confirm".localized, textColor: Color.blue, backgroundColor: Color.gray.opacity(0.2), disable: true)
            case 1:
                applyButtonView(text: "approved".localized, textColor: Color.blue, backgroundColor: Color.gray.opacity(0.2), disable: true)
            case 2:
                applyButtonView(text: "rejected".localized, textColor: Color.blue, backgroundColor: Color.gray.opacity(0.2), disable: true)
            case 3:
                applyButtonView(text: "recieved".localized, textColor: Color.blue, backgroundColor: Color.gray.opacity(0.2), disable: true)
            case 4:
                applyButtonView(text: "pending".localized, textColor: Color.blue, backgroundColor: Color.gray.opacity(0.2), disable: true)
            default: do {
                applyButtonView(text: "register_now".localized, textColor: Color.blue, backgroundColor: Color("nissho_light_blue"), disable: false)
            }
            }
        }
    }
    
    func applyButtonView(text: String, textColor: Color, backgroundColor: Color, disable: Bool) -> some View {
        Button(action: {
            self.benefitDetailViewModel.isPresentedPopup = true
            
            // Click count
            countClick(contentId: benefitDetailViewModel.benefit.id, contentType: Constants.ViewContent.TYPE_BENEFIT)
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
        BenefitDetailView()
            .environmentObject(BenefitDetailViewModel())
            .environmentObject(HomeScreenViewModel())
            .environmentObject(ListOfBenefitsViewModel())
    }
}
