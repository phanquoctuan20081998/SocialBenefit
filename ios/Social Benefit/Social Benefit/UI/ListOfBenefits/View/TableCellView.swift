//
//  ListOfBenefitViewController.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct TableCellView: View {
    
    @Binding var isPresentedApplyPopUp: Bool
    @Binding var selectedBenefit: Int
    @Binding var selectedIndex: Int
    
    let benefitData: BenefitData
    var index: Int
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            URLImageView(url: benefitData.logo)
                .frame(width: 50, height: 50)
                .clipped()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(benefitData.title)
                    .frame(width: ScreenInfor().screenWidth * 0.45, alignment: .leading)
                
                HStack(spacing: 13) {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(.green)
                        .font(.system(size: 15))
                    
                    Text(benefitData.actionTime)
                        .bold()
                        .foregroundColor(.blue)
                        .font(.system(size: 10))
                }
            }.font(.system(size: 13))

            switch benefitData.mobileStatus {
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_ON_GOING: do {
                Text("on_going".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_UP_COMMING: do {
                Text("up_comming".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_RECEIVED: do {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.green)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_NOT_REGISTER: do {
                
                Button(action: {
                    //do something
                    self.isPresentedApplyPopUp = true
                    self.selectedBenefit = benefitData.id
                    self.selectedIndex = index
                    
                    // Click count
                    countClick(contentId: benefitData.id, contentType: Constants.ViewContent.TYPE_BENEFIT)
                    
                }, label: {
                
                    RoundedButton(text: "apply".localized, font: .system(size: 30, weight: .regular, design: .default), backgroundColor: Color.blue, textColor: Color.white, cornerRadius: 10)
                            .font(.system(size: 13, weight: .black, design: .default))
                            .frame(width: ScreenInfor().screenWidth * 0.25, height: 20)
                })
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_REGISTER: do {
                Text("waiting".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_REJECTED: do {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
                
            case BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_PENDING_REGISTER: do {
                RoundedButton(text: "pending".localized, font: .system(size: 30, weight: .regular, design: .default), backgroundColor: Color.gray.opacity(0.2), textColor: Color.blue, cornerRadius: 10)
                    .font(.system(size: 15, weight: .black, design: .default))
                    .frame(width: ScreenInfor().screenWidth * 0.25, height: 20)
                    .disabled(true)
            }
                
            default: do {
                //Do something
                Text("".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.25)
            }
            }
        }.font(.system(size: 13))
    }
}


struct TableCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            
            let headers = ["order".localized, "benefit".localized, "benefit_status".localized]
            let scale = [0.17, 0.6, 0.2]
            
            HStack(spacing: 0) {
                
                ForEach(headers.indices, id: \.self) { i in
                    Text(headers[i])
                        .bold()
                        .frame(width: ScreenInfor().screenWidth * CGFloat(scale[i]), height: 20)
                }
            }
            .padding(.vertical, 10)
            .frame(width: ScreenInfor().screenWidth)
            .background(Color(#colorLiteral(red: 0.6202182174, green: 0.7264552712, blue: 0.9265476465, alpha: 1)))
            
            ScrollView {
                TableCellView(isPresentedApplyPopUp: .constant(true), selectedBenefit: .constant(0), selectedIndex: .constant(0), benefitData: BenefitData(id: 0, title: "dcasgdvasgdvasvdvasdvvsadjhasvjdasdvasvdhjasvdjhvasjhdvahsvdhasvdasvdjasvjdvasdvasvdavdhavhdvashjdvahjsvdahsvdavdhjavdavhdvahdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 0, mobileStatus: 0, actionTime: "20/08/1998"), index: 0)
                
                Divider()
            }
        }
    }
}
