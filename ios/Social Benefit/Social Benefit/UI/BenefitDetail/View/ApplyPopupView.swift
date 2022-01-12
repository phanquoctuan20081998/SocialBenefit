//
//  ApplyPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import SwiftUI
 
struct ApplyPopupView: View {
    
    @EnvironmentObject var benefitDetailViewModel: BenefitDetailViewModel
    @EnvironmentObject var listOfBenefitsViewModel: ListOfBenefitsViewModel
    
    @Binding var reload: Bool
    
    var benefitId: Int
    var index: Int
    
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
                        DispatchQueue.main.async {
                            self.benefitDetailViewModel.isPresentedPopup = false
                        }
                    }, label: {
                        Text("cancel_button".localized)
                    })
                    
                    Button(action: {
                        ApplyBenefitService().getAPI(benefitId: benefitId) { error in
                            DispatchQueue.main.async {
                                self.benefitDetailViewModel.isPresentedPopup = false
                                
                                if error.isEmpty {
                                    self.benefitDetailViewModel.applyStatus = 0 //Change to waiting to confirm
                                    self.reload = true
                                } else if error == MessageID.C00189_E {
                                    // If running out of registrations
                                    DispatchQueue.main.async {
                                        // Set apply button to pending
                                        self.benefitDetailViewModel.applyStatus = 4 // In benefit detail screen
                                        self.listOfBenefitsViewModel.listOfBenefits[index].mobileStatus = BenefitData.MOBILE_STATUS.MOBILE_BENEFIT_STATUS_PENDING_REGISTER // In list of benefits screen
                                    }
                                } else {
                                    self.benefitDetailViewModel.isPresentError = true
                                    self.benefitDetailViewModel.errorCode = error
                                }
                            }
                        }
                    }, label: {
                        Text("ok_button".localized)
                    })
                }.foregroundColor(.blue)
                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 30))
            }
        }
    }
}

struct BenefitErrorPopUpView: View {
    
    @EnvironmentObject var benefitDetailViewModel: BenefitDetailViewModel
    @EnvironmentObject var listOfBenefitsViewModel: ListOfBenefitsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if benefitDetailViewModel.isPresentError {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            benefitDetailViewModel.isPresentError = false
                            benefitDetailViewModel.isPresentedPopup = false
                        }
                    }
                
                ContentView
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(.black)
    }
    
    var ContentView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                
                Image("app_icon")
                    .resizable()
                    .frame(width: 40, height: 40)
                Text("fail_to_register".localized)
                    .font(.system(size: 25))
            }
            
            Text(benefitDetailViewModel.errorCode.localized)
            
            Spacer()
            Button {
                DispatchQueue.main.async {
                    benefitDetailViewModel.isPresentError = false
                    benefitDetailViewModel.isPresentedPopup = false
                    self.presentationMode.wrappedValue.dismiss()
                    self.listOfBenefitsViewModel.listOfBenefits.remove(at: benefitDetailViewModel.index)
                }
            } label: {
                Text("ok".localized.uppercased())
                    .foregroundColor(.blue)
                    .frame(width: ScreenInfor().screenWidth * 0.6, alignment: .trailing)
            }
        }
        .padding(30)
        .frame(width: ScreenInfor().screenWidth * 0.8, height: 200)
        .background(Color.white)
        .cornerRadius(30)
    }
}

struct ApplyPopUp_Previews: PreviewProvider {
    static var previews: some View {
        BenefitErrorPopUpView()
    }
}
