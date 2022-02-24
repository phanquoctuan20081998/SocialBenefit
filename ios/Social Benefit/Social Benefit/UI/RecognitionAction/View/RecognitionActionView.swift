//
//  RecognitionActionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 02/12/2021.
//

import SwiftUI
import Alamofire

struct RecognitionActionView: View {
    
    @ObservedObject var recognitionActionViewModel = RecognitionActionViewModel()
    @ObservedObject var keyboardHandler = KeyboardHandler()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    @State var addMoreClick: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: ScreenInfor().screenHeight * 0.13)
                
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
            
            // Confirm Popup
            PopUpView(isPresentedPopUp: $recognitionActionViewModel.isPresentConfirmPopUp, outOfPopUpAreaTapped: self.outOfPopupClick, popUpContent: AnyView(ConfirmPopUpView))
            
        }
        .onTapGesture(perform: {
            Utils.dismissKeyboard()
        })
        .background(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: true, isHiddenTabBarWhenBack: false, isHaveDiffirentHandle: true, diffirentHandle: backButtonClick))
        .edgesIgnoringSafeArea(.all)
        .background(
            NavigationLink(destination: NavigationLazyView(UserSearchView().environmentObject(recognitionActionViewModel)),
                           isActive: $addMoreClick,
                           label: { EmptyView() })
        )
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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
                            recognitionActionViewModel.selectedTab = 0
                        }
                    }
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.00001))
                    .frame(width: ScreenInfor().screenWidth * 0.93 / 2 - 15, height: 85, alignment: .bottom)
                    .onTapGesture {
                        withAnimation {
                            recognitionActionViewModel.selectedTab = 1
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
            
            NotePointView
            AddMorePersonButton
        }
        .background(Color.white)
        .environmentObject(recognitionActionViewModel)
    }
    
    var NotePointView: some View {
        VStack {
            Text("note_point_text".localizeWithFormat(arguments: "2023", "2022"))
        }.padding()
    }
    
    var SendPointButton: some View {
        Button {
            self.recognitionActionViewModel.sendButtonClick()
            
            // Click count
            countClick()
            
        } label: {
            Text("send_point".localized.uppercased())
                .bold()
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color("nissho_blue"))
                                .frame(width: ScreenInfor().screenWidth * 0.93, alignment: .trailing))
        }
        .padding(.top, 5)
        .padding(.bottom, ScreenInfor().screenHeight * 0.04)
    }
    
    var AddMorePersonButton: some View {
        Text("add_more_person".localized)
            .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .trailing)
            .foregroundColor(.blue)
            .onTapGesture {
                recognitionActionViewModel.isAddMoreClick = true
                addMoreClick = true
            }
        
    }
    
    var ConfirmPopUpView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("warning".localized)
                .font(.system(size: 20))
                .padding(.top, 10)
            
            Text("there_are_unsaved_changes".localized)
            
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
        .background(Color.white.cornerRadius(20))
        
    }
    
    func outOfPopupClick() {
        DispatchQueue.main.async {
            self.recognitionActionViewModel.isPresentConfirmPopUp = false
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
