//
//  RecognitionUsesBlockView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/12/2021.
//

import SwiftUI

struct RecognitionUsesBlockView: View {
    @EnvironmentObject var recognitionActionViewModel: RecognitionActionViewModel
    var index: Int
    
    @State var addMoreClick: Bool = false
    @State var isPresentPopUp: Bool = false
    
    var body: some View {
        if recognitionActionViewModel.allSelectedUser[index].getId() == -1 && recognitionActionViewModel.realCount > 0 {
            EmptyView()
        } else {
            ZStack {
                VStack(spacing: 20) {
                    
                    ComplimentsToButton
                        .onTapGesture {
                            self.recognitionActionViewModel.selectedUserIndex = index
                            self.addMoreClick = true
                        }
                    PointsView
                    
                    SendWishes
                    Rectangle()
                        .frame(width: ScreenInfor().screenWidth * 0.93, height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    Spacer()
                }.frame(width: ScreenInfor().screenWidth, alignment: .bottom)
                
                MoreOptionPopUp
                    .foregroundColor(.black)
                    .offset(x: 70, y: -40)
                
            }
            .background(
                NavigationLink(destination: NavigationLazyView(UserSearchView().environmentObject(recognitionActionViewModel)),
                               isActive: $addMoreClick,
                               label: { EmptyView() })
            )
        }
    }
}

extension RecognitionUsesBlockView {
    
    var ComplimentsToButton: some View {
        VStack(spacing: 10) {
            
            let currentUser = recognitionActionViewModel.allSelectedUser[index]
            
            if currentUser.getId() == -1 && recognitionActionViewModel.realCount == 0 && index == 0 {
                HStack {
                    Text("compliments_to".localized)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                
                Rectangle()
                    .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                    .foregroundColor(.gray.opacity(0.4))
            } else {
                HStack {
                    UserCardView(avatar: currentUser.getAvatar(), userName: currentUser.getFullName(), positionName: currentUser.getPositionName(), departmentName: currentUser.getDepartmentName(), isInUserView: true)
                    Spacer()
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(.gray.opacity(0.4))
                        .frame(width: 20, height: 20)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                self.isPresentPopUp = true
                            }
                        }
                }.frame(width: ScreenInfor().screenWidth * 0.85, alignment: .leading)
            }
            
            if recognitionActionViewModel.isUserEmpty {
                Text("user_empty".localized)
                    .font(.system(size: 13))
                    .foregroundColor(.red)
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
            }
        }.frame(width: ScreenInfor().screenWidth * 0.8)
    }
    
    var SendWishes: some View {
        VStack {
            if index < recognitionActionViewModel.wishesText.count {
                AutoResizeTextField(text: $recognitionActionViewModel.wishesText[index], isFocus: .constant(false), minHeight: 80, maxHeight: 500, placeholder: "send_wishes".localized, textfiledType: Constants.AutoResizeTextfieldType.RECOGNITION_ACTION)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
                                    .foregroundColor(.white))
                    .onTapGesture {
                        recognitionActionViewModel.resetError()
                    }
            }
            
            if recognitionActionViewModel.isWishEmpty {
                Text("wishes_empty".localized)
                    .font(.system(size: 13))
                    .foregroundColor(.red)
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
            }
        }
        .frame(width: ScreenInfor().screenWidth * 0.8)
    }
    
    var MoreOptionPopUp: some View {
        
        ZStack {
            if self.isPresentPopUp {
                Color.white
                    .opacity(0.0001)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.isPresentPopUp = false
                        }
                    }
                
                VStack(alignment: .leading, spacing: 20) {
                    Button {
                        self.recognitionActionViewModel.selectedUserIndex = index
                        self.addMoreClick = true
                        self.isPresentPopUp = false
                    } label: {
                        Text("change_person".localized)
                    }
                    
                    Button {
                        self.recognitionActionViewModel.allSelectedUser[index] = UserData()
                        self.recognitionActionViewModel.removeTextControl(index: index)
                        self.isPresentPopUp = false
                        
                        if self.recognitionActionViewModel.realCount > 0 {
                            self.recognitionActionViewModel.realCount -= 1
                        }
                        
                        recognitionActionViewModel.resetError()
                    } label: {
                        Text("remove".localized)
                    }
                }
                .padding()
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 0))
            }
        }
    }
    
    var PointsView: some View {
        VStack(spacing: 10) {
            if index < recognitionActionViewModel.pointText.count {
                HStack {
                    
                    TextFieldDynamicWidth(title: "0", text: $recognitionActionViewModel.pointText[index])
                        .keyboardType(.numberPad)
                        .font(.system(size: 35))
                        .frame(height: 30)
                        .onTapGesture {
                            recognitionActionViewModel.resetError()
                        }
                    
                    Text("\((recognitionActionViewModel.pointInt[index] == 0 || recognitionActionViewModel.pointInt[index] == 1) ? "point".localized : "points".localized)")
                    
                    Spacer()
                    
                }.foregroundColor(recognitionActionViewModel.pointInt[index] == 0 ? .gray : .black)
            }
            
            if recognitionActionViewModel.isPointEmpty {
                Text("point_empty".localized)
                    .font(.system(size: 13))
                    .foregroundColor(.red)
                    .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
            }
            
            Rectangle()
                .frame(width: ScreenInfor().screenWidth * 0.8, height: 1)
                .foregroundColor(.gray.opacity(0.4))
            
        }.frame(width: ScreenInfor().screenWidth * 0.8)
    }
}

struct RecognitionUsesBlockView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionActionView()
    }
}
