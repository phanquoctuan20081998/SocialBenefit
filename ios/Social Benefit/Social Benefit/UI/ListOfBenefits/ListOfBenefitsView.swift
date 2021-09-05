//
//  ListOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct ListOfBenefitsView: View {
    
    @State var data: [ListOfBenefitData] = []
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                Spacer(minLength: 50)
                HStack {
                    //Add back button
                    Button(action: {
                        //Do something
                   
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.leading, 20)
                    })
                    .padding(.leading, -140)


                    //Add logo
                    Image(uiImage: (Constant.baseURL + userInfor.companyLogo).loadURLImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .padding()
                }
                //Add title
                let header = ["order".localized, "benefit".localized, "benefit_status".localized]
                Text("benefit_title".localized)
                    .font(.bold(.headline)())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
                    .foregroundColor(.blue)
                
                Divider()
                
                //Add header
                let screen = ScreenInfor()
                HStack(spacing: 0) {
                    benefitText(text: header[0], scaleRatio: 5, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                    benefitText(text: header[1],scaleRatio: 2.5, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                    benefitText(text: header[2], scaleRatio: 3, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                }.frame(width: screen.screenWidth, alignment: .center)
                .padding(.all, 7)
                .background(Color.init(red: 158/255, green: 185/255, blue: 236/255))
                
                //Add tabble view
                List {
                    ForEach(data, id: \.self) { item in
                        TableCellView(benefitData: item)
                    }.listRowBackground(Color.init(red: 220/255, green: 230/255, blue: 250/255))
                }
                .onAppear {
                    ListOfBenefitsService().getAPI { (data) in
                        self.data = data
                    }
                }
            }
            .background(Color.init(red: 220/255, green: 230/255, blue: 250/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}


@available(iOS 13.0.0, *)
struct ListOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfBenefitsView()
    }
}
