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
                //do somthing
            }, label: {
                Text("Apply")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
            })
            .frame(width: width*0.13, height: 10)
            .minimumScaleFactor(0.5)
            .padding(.all, 10)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
        .frame(width: width/3.3, alignment: .center)
    }
}

struct TableCellView: View {
    
    let benefitData: ListOfBenefitData
    
    var body: some View {
        let screen = ScreenInfor()
        HStack(spacing: 15) {
            benefitText(text: benefitData.order, scaleRatio: 9, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: false)
                .padding(.leading, 10)
            benefitText(text: benefitData.benefit,scaleRatio: 2.5, width: screen.screenWidth - 22*2, isCenter: false, isItalic: false, isBold: false)
            
            switch benefitData.applied {
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
            case 6: do {
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
        List {
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "1", benefit: "dfsdfsd", applied: 1))
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "2", benefit: "dfsdsdsfsdfsdfsdfsdfsdfsfsdsdfdfsdfsfsdfsfsfssdddfsd", applied: 2))
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "3", benefit: "dfsdfsd", applied: 3))
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "4", benefit: "dfsdhcbdsbhdbkfhfgwuhkjncnhsfgbcbcbsdhjfsd", applied: 4))
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "5", benefit: "dfsdfsd", applied: 6))
            TableCellView(benefitData: ListOfBenefitData(id: 0, order: "6", benefit: "dfsdfsd", applied: 0))
            
//            TableCellView()
        }
    }
}
