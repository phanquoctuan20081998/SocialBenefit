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
        PopUpView(isPresentedPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp, outOfPopUpAreaTapped: outOfPopUpAreaTapped, popUpContent: AnyView(PopUpContent))
            .overlay(ConfirmPopUp(isPresentedPopUp: $isPresentComfirmPopUp, isPresentedPreviousPopUp: $customerSupportViewModel.isPresentCustomerSupportPopUp))
    }
}

extension CustomerSupportPopUp {
    
    var PopUpContent: some View {
        VStack {
            Image(systemName: "text.bubble.fill")
                .foregroundColor(.green)
                .font(.system(size: 30))
            
            Text("how_can_we_help".localized)
                .font(.system(size: 15))
            
            Spacer().frame(height: 20)
            
            // Move to select report screen...
            NavigationLink(
                destination: SearchSelectionView(selectedTab: $customerSupportViewModel.screenProblemText)
                    .navigationBarHidden(true),
                label: {
                    FeedBackTextField(placeHolder: "select_screen_problem", text: $customerSupportViewModel.screenProblemText, height: 30)
                        .disabled(true)
                })

            FeedBackTextField(placeHolder: "select_screen_problem", text: $customerSupportViewModel.feedBackText, height: 100)
            
            Spacer().frame(height: 20)
            
            HStack {
            
                // Send button...
                Button(action: {
                    customerSupportViewModel.sendButtonTapped()
                }, label: {
                    Text("send".localized)
                        .foregroundColor(customerSupportViewModel.feedBackText.isEmpty ? .gray : .black)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(#colorLiteral(red: 0.6876488924, green: 0.7895539403, blue: 0.9556769729, alpha: 1)))
                                        .frame(width: 80))
                }).disabled(customerSupportViewModel.feedBackText.isEmpty)
                
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
                        .frame(width: ScreenInfor().screenWidth * 0.9, height: 300))
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
            AutoResizeTextField(text: text, isFocus: $isFocus, minHeight: height, maxHeight: height, placeholder: placeHolder)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFocus ? Color.blue : Color.gray, lineWidth: isFocus ? 3 : 1))
            
        }.padding(.horizontal, 20)
    }
}

struct CustomerSupportPopUp_Previews: PreviewProvider {
    static var previews: some View {
        CustomerSupportPopUp()
    }
}
