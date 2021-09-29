//
//  ApplyPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI

struct ApplyPopupView: View {
    
    @EnvironmentObject var benefitDetailViewModel: BenefitDetailViewModel
    
    var body: some View {
        ZStack {
            if self.benefitDetailViewModel.isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.benefitDetailViewModel.isPresentedPopup = false
                    }
                
                popupContent
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                           .fill(Color.white)
                    )
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 150)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
    }
}

extension ApplyPopupView {
    
    var popupContent: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text("apply_this_benefit".localized)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("want_to_apply".localized)
            }.padding(.init(top: 25, leading: 30, bottom: 0, trailing: 0))
            
            Spacer()
            
            HStack {
                Spacer()
                HStack(spacing: 30) {
                    Button(action: {
                        self.benefitDetailViewModel.isPresentedPopup = false
                    }, label: {
                        Text("cancel_button".localized)
                    })
                    
                    Button(action: {
                        ApplyBenefitService().getAPI(benefitId: self.benefitDetailViewModel.benefit.id)
                        self.benefitDetailViewModel.isPresentedPopup = false
                        self.benefitDetailViewModel.applyStatus = 0 //Change to waiting to confirm
                    }, label: {
                        Text("ok_button".localized)
                    })
                }.foregroundColor(.blue)
                .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 30))
            }
        }
    }
}

struct ApplyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ApplyPopupView()
            .environmentObject(BenefitDetailViewModel())
    }
}
