//
//  ListOfBenefitViewController.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct TableCellView: View {
    
    let benefitData: BenefitData
    
    var body: some View {
        
        HStack(spacing: 20) {
            URLImageView(url: benefitData.logo)
                .frame(width: 50, height: 50)
            
            Text(benefitData.title)
                .frame(width: ScreenInfor().screenWidth * 0.5, alignment: .leading)

            switch benefitData.mobileStatus {
            case 0: do {
                Text("on_going".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
            }
            case 1: do {
                Text("up_comming".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
            }
            case 2: do {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .foregroundColor(.green)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
            }
            case 3: do {
                
                Button(action: {
                    //do something
                    
                    
                }, label: {
                    RoundedButton(text: "apply".localized, font: .system(size: 30, weight: .regular, design: .default), backgroundColor: Color.blue, textColor: Color.white, cornerRadius: 10)
                        .font(.system(size: 15, weight: .black, design: .default))
                        .frame(width: ScreenInfor().screenWidth * 0.2, height: 20)
                })
            }
            case 4: do {
                Text("waiting".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
            }
            case 6: do {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
            }
            default: do {
                //Do something
                Text("".localized)
                    .italic()
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.2)
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
                TableCellView(benefitData: BenefitData(id: 0, title: "dcasgdvasgdvasvdvasdvvsadjhasvjdasdvasvdhjasvdjhvasjhdvahsvdhasvdasvdjasvjdvasdvasvdavdhavhdvashjdvahjsvdahsvdavdhjavdavhdvahdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 0, mobileStatus: 0))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 1, mobileStatus: 1))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 2, mobileStatus: 2))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdsdfsdfsfsdfssdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 4, mobileStatus: 3))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: -1, status: -1, mobileStatus: 6))
                
                Divider()
                
            }
        }
    }
}
