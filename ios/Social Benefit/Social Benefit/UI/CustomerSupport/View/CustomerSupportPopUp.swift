//
//  CustomerSupportPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/10/2021.
//

import SwiftUI

struct CustomerSupportPopUp: View {
    
    @EnvironmentObject var customerSupportViewModel: CustomerSupportViewModel
    @State var isPresentComfirmPopUp = false
    
    var body: some View {
        if customerSupportViewModel.isLoading {
            PopUpView(isPresentedPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp,
                      outOfPopUpAreaTapped: outOfPopUpAreaTapped,
                      popUpContent: AnyView(ActivityRep()
                                                .background(RoundedRectangle(cornerRadius: 20)
                                                                .fill(Color.white)
                                                                .frame(width: ScreenInfor().screenWidth * 0.9, height: 300))))
        } else if customerSupportViewModel.isSuccessed {
            PopUpView(isPresentedPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp,
                      outOfPopUpAreaTapped: outOfPopUpAreaTapped,
                      popUpContent: AnyView(SuccessedPopUp))            
        } else {
            PopUpView(isPresentedPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp, outOfPopUpAreaTapped: outOfPopUpAreaTapped, popUpContent: AnyView(PopUpContent))
                .overlay(ConfirmPopUp(isPresentedPopUp: $isPresentComfirmPopUp, isPresentedPreviousPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp, variable: .constant(true)))
        }
    }
}

extension CustomerSupportPopUp {
    
    var PopUpContent: some View {
        VStack {
            Image(systemName: "text.bubble.fill")
                .foregroundColor(.green)
                .font(.system(size: 30))
                .padding(.bottom, 5)
            
            Text("how_can_we_help".localized)
                .font(.system(size: 15))
            
            Spacer().frame(height: 20)
            
            // Move to select report screen...
            NavigationLink(
                destination: NavigationLazyView(SearchSelectionView(selectedTab: $customerSupportViewModel.screenProblemText)),
                label: {
                    FeedBackTextField(placeHolder: "select_screen_problem".localized, text: $customerSupportViewModel.screenProblemText, height: 40)
                        .disabled(true)
                })

            FeedBackTextField(placeHolder: "describe_your_problem".localized, text: $customerSupportViewModel.feedBackText, height: 100)
            
            Spacer().frame(height: 20)
            
            HStack {
            
                // Send button...
                Button(action: {
                    customerSupportViewModel.sendButtonTapped()
                    
                    // Click count
                    countClick()
                }, label: {
                    Text("send".localized)
                        .foregroundColor(customerSupportViewModel.feedBackText.trimmingCharacters(in: .whitespaces).isEmpty ? .gray : .black)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color("nissho_light_blue"))
                                        .frame(width: 80))
                }).disabled(customerSupportViewModel.feedBackText.trimmingCharacters(in: .whitespaces).isEmpty)
                
                Spacer().frame(width: 80)
                
                
                //Cancel button...
                Button(action: {
                    withAnimation {
                        if customerSupportViewModel.isAllTextFieldAreBlank {
                            customerSupportViewModel.isPresentCustomerSupportPopUp = false
                        } else {
                            isPresentComfirmPopUp = true
                        }
                    }
                }, label: {
                    Text("cancel".localized)
                        .foregroundColor(.black)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                                        .frame(width: 80))
                })

            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: ScreenInfor().screenWidth * 0.9, height: 320))
    }
    
    var SuccessedPopUp: some View {
        VStack {
            Text("we_have_received_your_feedback".localized)
                .multilineTextAlignment(.center)
                .font(.system(size: 15))
                .frame(width: ScreenInfor().screenWidth * 0.7)
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 60))
            
            Spacer()
            
            Button {
                self.customerSupportViewModel.resetValue()
            } label: {
                Text("close".localized)
                    .font(.system(size: 15))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.gray.opacity(0.5)))
            }
        }
        .padding(.vertical, 30)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: ScreenInfor().screenWidth * 0.9, height: 300))
        .frame(width: ScreenInfor().screenWidth * 0.9, height: 300)
    }
    
    func outOfPopUpAreaTapped() {
        if customerSupportViewModel.isAllTextFieldAreBlank {
            withAnimation {
                customerSupportViewModel.isPresentCustomerSupportPopUp = false
            }
        } else {
            isPresentComfirmPopUp = true
        }
    }
}

struct FeedBackTextField: View {
    @State var isFocus: Bool = false
    var placeHolder: String
    var text: Binding<String>
    var height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            AutoResizeTextField(text: text, isFocus: $isFocus, minHeight: height, maxHeight: height, placeholder: placeHolder, textfiledType: Constants.AutoResizeTextfieldType.CUSTOMER_SUPPORT)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFocus ? Color.blue : Color.gray, lineWidth: isFocus ? 3 : 1))
            
        }
        .padding(.horizontal, 20)
        .frame(width: ScreenInfor().screenWidth * 0.9)
    }
}

struct CustomerSupportPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CustomerSupportPopUp()
            .environmentObject(CustomerSupportViewModel())
    }
}
