//
//  ListOfBenefitViewController.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct benefitText: View {
    var text: String
    var scaleRatio: CGFloat
    var width: CGFloat
    var isCenter: Bool
    var isItalic: Bool
    var isBold: Bool
    
    var body: some View {
        if isItalic {
            Text(text)
                .italic()
                .frame(width: width/scaleRatio, alignment: isCenter ? .center : .leading)
                .multilineTextAlignment(isCenter ? .center : .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(nil)
                .padding(.all, 10)
        } else if isBold {
            Text(text)
                .bold()
                .frame(width: width/scaleRatio, alignment: isCenter ? .center : .leading)
                .multilineTextAlignment(isCenter ? .center : .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(nil)
                .padding(.all, 10)
        } else {
            Text(text)
                .frame(width: width/scaleRatio, alignment: isCenter ? .center : .leading)
                .multilineTextAlignment(isCenter ? .center : .leading)
                .minimumScaleFactor(0.5)
                .lineLimit(nil)
                .padding(.all, 10)
        }
    }
}

struct benefitButton: View {
    var scaleRatio: CGFloat
    var width: CGFloat
    
    var body: some View {
        ZStack {
            Button(action: {
                //do something
                
                
            }, label: {
                RoundedButton(text: "Apply", font: .system(size: 30, weight: .regular, design: .default), backgroundColor: Color.blue, textColor: Color.white, cornerRadius: 10)
                    .font(.system(size: 20, weight: .black, design: .default))
            })
        }
        .frame(width: width/3.3, height: 40, alignment: .center)
    }
}

struct TableCellView: View {
    
    let benefitData: BenefitData
    
    var body: some View {
        let screen = ScreenInfor()
        HStack(spacing: 15) {
            URLImageView(url: benefitData.logo)
                .padding(.leading, 10)
            benefitText(text: benefitData.title,scaleRatio: 2.5, width: screen.screenWidth - 22*2, isCenter: false, isItalic: false, isBold: false)
            
            switch benefitData.mobileStatus {
            case 0: do {
                benefitText(text: "on_going".localized, scaleRatio: 4, width: screen.screenWidth - 22*2, isCenter: true, isItalic: true, isBold: false)
            }
            case 1: do {
                benefitText(text: "up_comming".localized, scaleRatio: 4, width: screen.screenWidth - 22*2, isCenter: true, isItalic: true, isBold: false)
            }
            case 2: do {
                benefitText(text: "☑️", scaleRatio: 4, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: false)
            }
            case 3: do {
                benefitButton(scaleRatio: 4, width: screen.screenWidth - 22*2)
            }
            case 4: do {
                benefitText(text: "waiting".localized, scaleRatio: 4, width: screen.screenWidth - 22*2, isCenter: true, isItalic: true, isBold: false)
            }
            case 5: do {
                benefitText(text: "❌", scaleRatio: 4, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: false)
            }
            default: do {
                //Do something
            }
            }
        }.frame(width: screen.screenWidth - 18*2, alignment: .center)
    }
}


struct TableCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            let header = ["order".localized, "benefit".localized, "benefit_status".localized]
            HStack(spacing: 0) {
                benefitText(text: header[0], scaleRatio: 5, width: ScreenInfor().screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                benefitText(text: header[1],scaleRatio: 2.5, width: ScreenInfor().screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                benefitText(text: header[2], scaleRatio: 3, width: ScreenInfor().screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
            }.frame(width: ScreenInfor().screenWidth, alignment: .center)
            .padding(.all, 7)
            .background(Color(#colorLiteral(red: 0.6202182174, green: 0.7264552712, blue: 0.9265476465, alpha: 1)))
            
            ScrollView {
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 0, mobileStatus: 0))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 1, mobileStatus: 1))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 2, mobileStatus: 2))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 3, mobileStatus: 3))
                Divider()
                
                TableCellView(benefitData: BenefitData(id: 0, title: "dcdcsc", body: "dchsdch", logo: "/files/608/iphone-11-xanhla-200x200.jpg", typeMember: 2, status: 4, mobileStatus: 4))
                Divider()
            }
        }
    }
}
