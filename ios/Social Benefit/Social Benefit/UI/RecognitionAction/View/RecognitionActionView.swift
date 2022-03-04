//
//  RecognitionActionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 02/12/2021.
//

import SwiftUI
import Alamofire

struct RecognitionActionView: View {
    
    @StateObject var recognitionActionViewModel = RecognitionActionViewModel()
    @ObservedObject var keyboardHandler = KeyboardHandler()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    @State var addMoreClick: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 70)
                
                if userInfor.isLeader {
                    CompanyAndPersonalBudgetView
                } else {
                    PersonalBudgetView
                }
                
                Spacer().frame(height: 20)
                
                SendPointActionView
                SendPointButton
            }
            .font(.system(size: 13))
            .offset(y: -keyboardHandler.keyboardHeight)
            
            // Error Present
            ErrorMessageView(error: "this_person_is_exist".localized, isPresentedError: $recognitionActionViewModel.isPresentError)
            
            ErrorMessageView(error: recognitionActionViewModel.errorText, isPresentedError: $recognitionActionViewModel.isPresentError)
            
            WhiteWarningMessageView(message: recognitionActionViewModel.warningText, isPresented: $recognitionActionViewModel.isPresentWarning)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 5, y: 5)
                .offset(y: -keyboardHandler.keyboardHeight)
            
            SuccessedMessageView(successedMessage: "successfully_sent".localized, color: .green, isPresented: $recognitionActionViewModel.isSendPointSuccess)
            
            // Confirm Popup
            PopUpView(isPresentedPopUp: $recognitionActionViewModel.isPresentConfirmPopUp, outOfPopUpAreaTapped: self.outOfPopupClick, popUpContent: AnyView(ConfirmPopUpView))
            PopUpView(isPresentedPopUp: $recognitionActionViewModel.isPresentSendConfirmPopUp, outOfPopUpAreaTapped: self.outOfPopupClick, popUpContent: AnyView(SendConfirmPopUpView))
            
        }
        .onTapGesture(perform: {
            Utils.dismissKeyboard()
        })
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "recognize".localized, isHaveLogo: true, isHiddenTabBarWhenBack: false, isHaveDiffirentHandle: true, diffirentHandle: backButtonClick))
        .background(
            ZStack {
                NavigationLink(destination: EmptyView(), label: {
                    EmptyView()
                })
                
                NavigationLink(destination: NavigationLazyView(UserSearchView().environmentObject(recognitionActionViewModel)),
                               isActive: $addMoreClick,
                               label: { EmptyView() })
            }
        )
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresKeyboard()
    }
}

extension RecognitionActionView {
    
    var PersonalBudgetView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: ScreenInfor().screenWidth * 0.93, height: 100, alignment: .bottom)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.blue)
                .frame(width: ScreenInfor().screenWidth * 0.93 - 15, height: 85, alignment: .bottom)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            
            VStack(spacing: 7) {
                Text("personal_budget".localized)
                
                getPointView(point: recognitionActionViewModel.personalPoint)
                    .font(.system(size: 20))
            }.foregroundColor(.white)
        }
    }
    
    var CompanyAndPersonalBudgetView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: ScreenInfor().screenWidth * 0.93, height: 100, alignment: .bottom)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            
            HStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.00001))
                    .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85, alignment: .bottom)
                    .onTapGesture {
                        withAnimation {
                            recognitionActionViewModel.selectedTab = RecognitionActionViewModel.Tab.COMPANY
                        }
                    }
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.00001))
                    .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85, alignment: .bottom)
                    .onTapGesture {
                        withAnimation {
                            recognitionActionViewModel.selectedTab = RecognitionActionViewModel.Tab.PERSONAL
                        }
                    }
            }
            HStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color("nissho_blue"))
                    .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85, alignment: .bottom)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
            }
            .frame(width: ScreenInfor().screenWidth * 0.93, alignment: recognitionActionViewModel.selectedTab == 0 ? .leading : .trailing)
            .padding(recognitionActionViewModel.selectedTab == 0 ? .leading : .trailing, 15)
            
            HStack(spacing: 10) {
                
                VStack(spacing: 7) {
                    Text("company_budget".localized)
                        .fontWeight(.medium)
                    getPointView(point: recognitionActionViewModel.companyPoint)
                }
                .font(.system(size: 13))
                .foregroundColor(recognitionActionViewModel.selectedTab == 0 ? .black : .gray.opacity(0.7))
                .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85)
                
                VStack(spacing: 7) {
                    Text("personal_budget".localized)
                        .fontWeight(.medium)
                    getPointView(point: recognitionActionViewModel.personalPoint)
                }
                .font(.system(size: 13))
                .foregroundColor(recognitionActionViewModel.selectedTab == 1 ? .black : .gray.opacity(0.7))
                .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85)
            }
        }
    }
    
    var SendPointActionView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // Recent Tranfers List
            if !recognitionActionViewModel.allUserList.isEmpty {
                RecentTransferListView
                    .padding(.bottom, recognitionActionViewModel.isShowRecentTransferList ? 0 : 20)
            } else {
                Spacer().frame(height: 20)
            }
            
            // Tranfer View Block
            VStack {
                Spacer().frame(height: 30)
                
                if recognitionActionViewModel.realCount == 0 {
                    // If no adding more user...
                    // Just print only 1 user block
                    RecognitionUsesBlockView(index: 0)
                } else {
                    ForEach(recognitionActionViewModel.allSelectedUser.indices, id: \.self) { index in
                        RecognitionUsesBlockView(index: index)
                    }
                }
            }
            
            .padding(.top, 10)
            .background(
                Color.white
                    .cornerRadius(radius: 50, corners: [.topLeft, .topRight])
                    .background(Rectangle()
                                    .cornerRadius(radius: 50, corners: [.topLeft, .topRight])
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0)
                                    .frame(height: 100), alignment: .top))
            
            Spacer()
            
            AddMorePersonButton
            
            if recognitionActionViewModel.selectedTab == RecognitionActionViewModel.Tab.COMPANY {
                NotePointView
            }
        }
        .background(Color.white)
        .environmentObject(recognitionActionViewModel)
    }
    
    var NotePointView: some View {
        let thisYear = Calendar.current.component(.year, from: Date())
        let nextYear = Calendar.current.component(.year, from: Calendar.current.date(byAdding: .year, value: 1, to: Date())!)
        
        return VStack {
            Text("note_point_text".localizeWithFormat(arguments: String(nextYear), String(thisYear)))
        }.padding()
    }
    
    var SendPointButton: some View {
        Button {
            self.recognitionActionViewModel.sendButtonClick()
            
            // Click count
            countClick()
            
        } label: {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("nissho_blue"))
                    .overlay(Text("send_point".localized.uppercased())
                                .bold()
                                .foregroundColor(.black)
                                .font(.system(size: 16)))
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .padding(EdgeInsets.init(top: 5, leading: 20, bottom: 5, trailing: 20))
        }
    }
    
    var AddMorePersonButton: some View {
        HStack {
            Spacer()
            Button {
                recognitionActionViewModel.isAddMoreClick = true
                addMoreClick = true
            } label: {
                Text("add_more_person".localized)
                    .foregroundColor(.blue)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }
    
    var ConfirmPopUpView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("warning".localized)
                .font(.system(size: 15))
                .padding(.top, 10)
            
            Text("there_are_unsaved_changes".localized)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 0)
            
            HStack {
                Button {
                    DispatchQueue.main.async {
                        recognitionActionViewModel.isPresentConfirmPopUp = false
                    }
                } label: {
                    Text("cancel".localized.uppercased())
                }
                
                Spacer().frame(width: 20)
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    
                    DispatchQueue.main.async {
                        recognitionActionViewModel.resetViewModel()
                        recognitionActionViewModel.isPresentConfirmPopUp = false
                    }
                    
                } label: {
                    Text("confirm".localized.uppercased())
                }
                
            }
            .foregroundColor(.blue)
            .frame(width: ScreenInfor().screenWidth * 0.7, alignment: .trailing)
        }
        .padding()
        .frame(width: ScreenInfor().screenWidth * 0.8, height: 170)
        .font(.system(size: 13))
        .background(Color.white.cornerRadius(20))
    }
    
    var SendConfirmPopUpView: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Image("app_icon")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("are_you_sure".localized)
                    .font(.system(size: 15))
                    .padding(.top, 10)
            }
            
            Text("are_you_sure_to_send".localizeWithFormat(arguments: String(recognitionActionViewModel.pointInt.reduce(0, +)), String(recognitionActionViewModel.pointInt.count)))
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 0)
            
            HStack {
                Button {
                    DispatchQueue.main.async {
                        recognitionActionViewModel.isPresentSendConfirmPopUp = false
                    }
                } label: {
                    Text("cancel".localized.uppercased())
                }
                
                Spacer().frame(width: 20)
                
                Button {
                    DispatchQueue.main.async {
                        recognitionActionViewModel.sendPoint()
                        recognitionActionViewModel.isPresentSendConfirmPopUp = false
                    }
                    
                } label: {
                    Text("confirm".localized.uppercased())
                }
                
            }
            .foregroundColor(.blue)
            .frame(width: ScreenInfor().screenWidth * 0.7, alignment: .trailing)
        }
        .padding()
        .frame(width: ScreenInfor().screenWidth * 0.8, height: 170)
        .font(.system(size: 13))
        .background(Color.white.cornerRadius(20))
    }
    
    func outOfPopupClick() {
        DispatchQueue.main.async {
            self.recognitionActionViewModel.isPresentConfirmPopUp = false
            self.recognitionActionViewModel.isPresentSendConfirmPopUp = false
        }
    }
    
    func backButtonClick() {
        if recognitionActionViewModel.isModified {
            DispatchQueue.main.async {
                recognitionActionViewModel.isPresentConfirmPopUp = true
            }
        } else {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct RecognitionActionView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionActionView()
    }
}
