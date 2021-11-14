//
//  UserInformationView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/08/2021.
//

import SwiftUI

struct UserInformationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var homeScreen: HomeScreenViewModel
    @ObservedObject var userInformationViewModel = UserInformationViewModel()
    
    var dateFormatter = getDataFormatter()
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer().frame(height: 60)
                
                ScrollView {
                    BasicInformationView.padding(.top, 30)
                    Spacer().frame(height: 15)
                    
                    PresentationView
                    Spacer().frame(height: 30)
                    
                    ContactView
                    Spacer().frame(height: 30)
                    
                    ButtonView
                    Spacer().frame(height: 30)
                }
            }.background(
                BackgroundViewWithoutNotiAndSearch(isActive: $homeScreen.isPresentedTabBar, title: "", isHaveLogo: true)
            )
            
            // Pop Up
            DatePickerPopupView()
            LocationPickerPopUpView()
            ImagePickerView()
            PopUpView(isPresentedPopUp: $userInformationViewModel.isPresentConfirmPopUp, outOfPopUpAreaTapped: outOfPopUpAreaTapped, popUpContent: AnyView(ConfirmPopUp))
            SuccessedMessageView(successedMessage: "Updated!", color: Color.green, isPresented: $userInformationViewModel.isSuccessed)
            
        }.environmentObject(userInformationViewModel)
    }
}

extension UserInformationView {
    
    var BasicInformationView: some View {
        VStack (spacing: 10) {
            Button(action: {
                //do something
                userInformationViewModel.isPresentedImagePicker.toggle()
                
            }, label: {
                
                if userInformationViewModel.image == nil {
                    URLImageView(url: userInfor.avatar)
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .padding(.all, 7)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        .overlay(
                            Image(systemName: "camera.fill")
                                .foregroundColor(.black.opacity(0.6))
                                .font(.system(size: 20))
                                .offset(x: 30, y: 30)
                        )
                } else {
                    Image(uiImage: userInformationViewModel.image!)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                        .padding(.all, 7)
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        .overlay(
                            Image(systemName: "camera.fill")
                                .foregroundColor(.black.opacity(0.6))
                                .font(.system(size: 20))
                                .offset(x: 30, y: 30)
                        )
                }
            })
            
            HStack {
                Text(userInfor.name)
                    .foregroundColor(.blue)
                    .bold()
                Text("-")
                Text(userInfor.userId)
                    .bold()
            }
            
            HStack {
                if !userInfor.position.isEmpty && !userInfor.department.isEmpty {
                    Text(userInfor.position)
                    Text("-")
                    Text(userInfor.department)
                } else if userInfor.position.isEmpty {
                    Text(userInfor.department)
                } else {
                    Text(userInfor.position)
                }
                
            }.font(.system(size: 12))
        }
    }

    
    var PresentationView: some View {
        VStack(spacing: 0) {
            Text("presentation".localized)
                .bold()
                .frame(width: ScreenInfor().screenWidth*0.8, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            VStack(spacing: 20) {
                
                InformationTextFieldView(text: $userInformationViewModel.nicknameText, title: "nickname".localized, placeHolder:  "nickname_placeholder".localized, showChevron: false, disable: false)
                
                LocationFieldView()
                
                DateFieldView(dateFormatter: dateFormatter)
                    .disabled(true)
                
                InformationTextFieldView(text: $userInformationViewModel.genderText, title: "gender".localized, placeHolder: userInfor.gender.localized, showChevron: true, disable: true)
                
                InformationTextFieldView(text: $userInformationViewModel.passportText, title: "passport".localized, placeHolder: (userInfor.CMND != "") ? userInfor.CMND : userInfor.passport, showChevron: false, disable: true)
                
                InformationTextFieldView(text: $userInformationViewModel.insuranceText, title: "insurance".localized, placeHolder: userInfor.insurance, showChevron: false, disable: true)
            }.padding(.all, 30)
        }.frame(width: ScreenInfor().screenWidth*0.9, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
            )
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
    }
    
    var ContactView: some View {
        VStack(spacing: 0) {
            Text("contact".localized)
                .bold()
                .frame(width: ScreenInfor().screenWidth*0.8, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            VStack (spacing: 20) {
                InformationTextFieldView(text: $userInformationViewModel.emailText, title: "contact_email".localized, placeHolder: userInfor.email, showChevron: false, disable: false)
                    .onTapGesture {
                        userInformationViewModel.resetError()
                    }
                    .overlay(
                        VStack {
                            if userInformationViewModel.isPresentEmailBlankError {
                                TextFieldErrorView(error: "blank_email")
                            } else if userInformationViewModel.isPresentWrongEmailError {
                                TextFieldErrorView(error: "wrong_email")
                            }
                        }, alignment: .trailing
                    )
                
                InformationTextFieldView(text: $userInformationViewModel.phoneText, title: "telephone".localized, placeHolder: userInfor.phone, showChevron: false, disable: false)
                    .keyboardType(.numberPad)
                    .overlay(
                        VStack {
                            if userInformationViewModel.isPresentPhoneBlankError {
                                TextFieldErrorView(error: "blank_phone")
                            }
                        }, alignment: .trailing
                    )
                    .onTapGesture {
                        userInformationViewModel.resetError()
                    }
            }.padding(.top, 30)
            
            HStack {
                if userInfor.isLeader {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                
                Text("leader".localized)
                    .bold()
                    .font(.system(size: 15))
            }.padding(.vertical, 15)
            
        }.frame(width: ScreenInfor().screenWidth*0.9, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 2)
            )
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
    }
    
    var ButtonView: some View {
        HStack {
            Button(action: {
                userInformationViewModel.saveButtonTapped()
            }, label: {
                Text("save".localized)
                    .foregroundColor(userInformationViewModel.isEnableSaveButton ? .black : .gray)
            })
                .frame(width: 60, height: 20)
                .padding(.all, 10)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                .disabled(!userInformationViewModel.isEnableSaveButton)
            
            Spacer()
                .frame(width: 30)
            
            Button(action: {
                if userInformationViewModel.isEnableSaveButton {
                    DispatchQueue.main.async {
                        userInformationViewModel.isPresentConfirmPopUp = true
                    }
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                    self.homeScreen.isPresentedTabBar.toggle()
                }
            }, label: {
                Text("cancel".localized)
                    .foregroundColor(.black)
            })
                .frame(width: 60, height: 20)
                .padding(.all, 10)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
    
    var ConfirmPopUp: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("warning".localized)
                .font(.system(size: 20))
            Text("there_are_unsaved_changes".localized)
                .font(.system(size: 15))
                .multilineTextAlignment(.leading)
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                Spacer()
                
                Button {
                    self.userInformationViewModel.isPresentConfirmPopUp.toggle()
                } label: {
                    Text("cancel".localized.uppercased())
                        .foregroundColor(.blue)
                }
                
                Spacer()
                    .frame(width: 20)
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    self.homeScreen.isPresentedTabBar.toggle()
                    self.userInformationViewModel.isPresentConfirmPopUp.toggle()
                } label: {
                    Text("confirm".localized.uppercased())
                        .foregroundColor(.blue)
                }

            }
        }
        .padding(.horizontal, 40)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 150)
        )
    }
    
    @ViewBuilder
    func TextFieldErrorView(error: String) -> some View {
        Text(getError(errorCode: error))
            .font(.system(size: 12))
            .foregroundColor(.red)
            .frame(height: 35)
            .padding(.horizontal, 10)
            .background(Color.white)
            .padding(.horizontal, 10)
    }
    
    func outOfPopUpAreaTapped() {
        userInformationViewModel.isPresentConfirmPopUp = false
    }
}

//Normal Text Field
struct InformationTextFieldView: View {
    
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    
    @Binding var text: String
    
    var title: String
    var placeHolder: String
    var showChevron: Bool
    var disable: Bool
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .font(.system(size: 13))
                .padding()
                .frame(width: ScreenInfor().screenWidth * 0.75, height: 40)
                .background(RoundedRectangle(cornerRadius: 13).stroke(Color.gray.opacity(0.2), lineWidth: 2))
                .overlay(TitleView(text: title))
                .overlay(
                    VStack {
                        if showChevron {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .offset(x: ScreenInfor().screenWidth * 0.32)
                        }
                    }
                )
                
                .if(disable) { view in
                    view.foregroundColor(.gray.opacity(0.4))
                }
                .disabled(disable)
        }
    }
}

// Date Picker Field
struct DateFieldView: View {
    
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    var dateFormatter: DateFormatter
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    userInformationViewModel.isPresentedDatePickerPopUp = true
                    userInformationViewModel.isChangedDatePickerPopUp = false
                }, label: {
                    let strDate = dateFormatter.string(from: userInformationViewModel.dateText)
                    Text(strDate)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 13))
                        .padding()
                        .frame(width: ScreenInfor().screenWidth*0.75, height: 40, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 13).stroke(Color.gray.opacity(0.2), lineWidth: 2
                                                                             ))
                        .overlay(TitleView(text: "birthday".localized))
                })
                    .foregroundColor(.black)
            }
        }
    }
}

// Location Picker Filed
struct LocationFieldView: View {
    
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    userInformationViewModel.isPresentedLocationPickerView.toggle()
                    userInformationViewModel.endDragOffsetY = 0
                    userInformationViewModel.filter = ""
                    userInformationViewModel.curLocationText = ""
                }, label: {
                    Text(userInformationViewModel.locationText)
                        .font(.system(size: 13))
                        .padding()
                        .frame(width: ScreenInfor().screenWidth * 0.75, height: 40, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 13).stroke(Color.gray.opacity(0.2), lineWidth: 2
                                                                             ))
                        .overlay(TitleView(text: "address".localized))
                        .overlay (
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .padding(10)
                                .background(Rectangle().fill(Color.white))
                                
                                .offset(x: ScreenInfor().screenWidth * 0.32)
                                
                        )
                })
                    .foregroundColor(.black)
            }
        }
    }
}

struct TitleView: View {
    var text: String
    var body: some View {
        ZStack {
            Text(text)
                .padding(.horizontal)
                .background(Color.white)
                .font(.system(size: 12, weight: .regular, design: .default))
                .foregroundColor(.black)
            
        }
        .frame(width: ScreenInfor().screenWidth - 30*2, height: 80, alignment: .leading)
        .padding(.bottom, 40)
        .padding(.leading, 50)
    }
}


func getDataFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    return dateFormatter
}

struct UserInformationView_Previews: PreviewProvider {
    static var previews: some View {
//        HomeScreenView(selectedTab: "")
//        HomeScreenView(selectedTab: "house")
        UserInformationView()
            .environmentObject(HomeScreenViewModel())
            .environmentObject(UserInformationViewModel())
            .environmentObject(MerchantVoucherDetailViewModel())
            .environmentObject(HomeScreenViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
    }
}
