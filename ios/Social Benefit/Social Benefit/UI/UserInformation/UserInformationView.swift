//
//  UserInformationView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/08/2021.
//

import SwiftUI

struct UserInformationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var isPresentedTabBar: Bool
    
    @State var nicknameText = userInfor.nickname
    @State var genderText = userInfor.gender.localized
    @State var insuranceText = userInfor.insurance
    @State var passportText = userInfor.passport
    @State var emailText = userInfor.email
    @State var phoneText = userInfor.phone
    
    //State variants to control Date Picker field
    @State var isPresentedDatePickerPopUp = false
    @State var isChangedDatePickerPopUp = false
    @State var dateText = userInfor.birthday
    @State var currentDate = Date()
    
    //State variants to control Location Picker field
    @State var isPresentedLocationPickerView = false
    @State var endDragOffsetY: CGFloat = 0
    @State var filter = ""
    @State var locationText = userInfor.address
    @State var curLocationText = ""
    
    var dateFormatter = getDataFormatter()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            ScrollView {
                BasicInformationView()
                    .padding(.top, 30)
                
                Spacer()
                    .frame(height: 30)
                
                VStack {
                    Text("presentation".localized)
                        .bold()
                        .frame(width: ScreenInfor().screenWidth*0.8, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack(spacing: 30) {
                        
                        InformationTextFieldView(text: $nicknameText, title: "nickname".localized, placeHolder: (userInfor.nickname == "") ? "nickname_placeholder".localized : userInfor.nickname, showChevron: false, disable: false)
                        
                        LocationFieldView(isPresented: $isPresentedLocationPickerView, endDragOffsetY: $endDragOffsetY, filter: $filter, text: $locationText, curText: $curLocationText)
                        
                        DateFieldView(isPresented: $isPresentedDatePickerPopUp, isChanged: $isChangedDatePickerPopUp, date: $dateText, currentDate: $currentDate, dateFormatter: dateFormatter)
                        
                        InformationTextFieldView(text: $genderText, title: "gender".localized, placeHolder: userInfor.gender.localized, showChevron: true, disable: true)
                        
                        InformationTextFieldView(text: $passportText, title: "passport".localized, placeHolder: (userInfor.CMND != "") ? userInfor.CMND : userInfor.passport, showChevron: false, disable: true)
                        
                        InformationTextFieldView(text: $insuranceText, title: "insurance".localized, placeHolder: userInfor.insurance, showChevron: false, disable: true)
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
                
                Spacer()
                    .frame(height: 30)
                
                VStack {
                    Text("contact".localized)
                        .bold()
                        .frame(width: ScreenInfor().screenWidth*0.8, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    VStack (spacing: 30) {
                        InformationTextFieldView(text: $emailText, title: "contact_email".localized, placeHolder: userInfor.email, showChevron: false, disable: false)
                        InformationTextFieldView(text: $passportText, title: "telephone".localized, placeHolder: userInfor.phone, showChevron: false, disable: false)
                    }.padding(.top, 30)
                    
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                        
                        Text("leader".localized)
                            .bold()
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
                
                
                Spacer()
                    .frame(height: 30)
                
                HStack {
                    Button(action: {
                        
                        
                        
                    }, label: {
                        Text("save".localized)
                            .foregroundColor(.black)
                    })
                    .frame(width: 60, height: 20)
                    .padding(.all, 10)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        self.isPresentedTabBar.toggle()
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
        }
        .overlay(DatePickerPopupView(isPresented: $isPresentedDatePickerPopUp, isChanged: $isChangedDatePickerPopUp, selectedDate: $dateText, currentDate: $currentDate))
        .overlay(LocationPickerPopUpView(curDragOffsetY: endDragOffsetY, isPresented: $isPresentedLocationPickerView, endDragOffsetY: $endDragOffsetY, filter: $filter, text: $locationText, curText: $curLocationText))
        .background(NoSearchBackgroundView(isActive: $isPresentedTabBar))
        
    }
}

//Normal Text Field
struct InformationTextFieldView: View {
    
    @Binding var text: String
    
    var title: String
    var placeHolder: String
    var showChevron: Bool
    var disable: Bool
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .font(.system(size: 15))
                .padding()
                .frame(width: ScreenInfor().screenWidth*0.75, height: 40)
                .background(RoundedRectangle(cornerRadius: 13).stroke(Color.gray.opacity(0.2), lineWidth: 2
                ))
                .overlay(TitleView(text: title))
                .if(showChevron) {view in
                    view.overlay(
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                            .offset(x: ScreenInfor().screenWidth * 0.32)
                    )
                }
                .if(disable) { view in
                    view.foregroundColor(.gray.opacity(0.4))
                }
                .disabled(disable)
        }
    }
}

// Date Picker Field
struct DateFieldView: View {
    
    @Binding var isPresented: Bool
    @Binding var isChanged: Bool
    @Binding var date: Date
    @Binding var currentDate: Date
    var dateFormatter: DateFormatter
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    isPresented = true
                    isChanged = false
                }, label: {
                    //                    let strDate = dateFormatter.string(from: isChanged ? date : currentDate)
                    let strDate = dateFormatter.string(from: date)
                    Text(strDate)
                        .font(.system(size: 15))
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
    
    @Binding var isPresented: Bool
    @Binding var endDragOffsetY: CGFloat
    @Binding var filter: String
    @Binding var text: String
    @Binding var curText: String
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    isPresented.toggle()
                    endDragOffsetY = 0
                    filter = ""
                    curText = ""
                }, label: {
                    Text(text)
                        .font(.system(size: 15))
                        .padding()
                        .frame(width: ScreenInfor().screenWidth*0.75, height: 40, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 13).stroke(Color.gray.opacity(0.2), lineWidth: 2
                        ))
                        .overlay(TitleView(text: "address".localized))
                        .overlay (
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
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


struct BasicInformationView: View {
    var body: some View {
        VStack (spacing: 10) {
            Button(action: {
                //do something
                print(userInfor)
                
            }, label: {
                Image(uiImage: (Constant.baseURL + userInfor.avatar).loadURLImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
                Text(userInfor.position)
                Text("-")
                Text(userInfor.department)
            }.font(.system(size: 12))
        }
    }
}

struct UserInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationView(isPresentedTabBar: .constant(true))
    }
}

func getDataFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    return dateFormatter
}
