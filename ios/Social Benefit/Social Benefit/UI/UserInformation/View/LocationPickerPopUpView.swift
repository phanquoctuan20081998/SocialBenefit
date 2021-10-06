//
//  LocationPickerPopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/08/2021.
//

import SwiftUI
import Alamofire

struct LocationPickerPopUpView: View {
    
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    
    var body: some View {
        DragPopUp(isPresent: $userInformationViewModel.isPresentedLocationPickerView, contentView: AnyView(LocationPickerView()))
    }
}


struct LocationPickerView: View {
    
    @State var data: [LocationData] = []
    @State var typedText = ""
    @EnvironmentObject var userInformationViewModel: UserInformationViewModel
    
    var body: some View {
        if userInformationViewModel.filter.count == 0 {
            LocationPickerContent
        } else if userInformationViewModel.filter.count == 2 {
            LocationPickerContent
        } else if userInformationViewModel.filter.count == 3 {
            LocationPickerContent
        } else {
            LocationTyperContent
        }
    }
    
    // Display content for picking
    var LocationPickerContent: some View {
        VStack (alignment: .center) {
            HStack {
                Button(action: {
                    userInformationViewModel.isPresentedLocationPickerView.toggle()
                    if userInformationViewModel.curLocationText != "" {
                        userInformationViewModel.locationText = userInformationViewModel.curLocationText
                    }
                }, label: {
                    Image(systemName: "xmark")
                })
                    .padding(.leading, 50)
                    .padding(.bottom, 15)
                
                Text("choose_city".localized)
                    .frame(width: ScreenInfor().screenWidth - 100, alignment: .center)
                    .padding(.trailing, 60)
                    .padding(.bottom, 15)
            }.padding(.top, 25)
//                .gesture(dragGesture)
            
            Divider()
            
            ScrollView {
                VStack {
                    ForEach(data, id: \.self) { item in
                        VStack {
                            Text(item.name)
                                .frame(width: ScreenInfor().screenWidth - 70, height: 30, alignment: .leading)
                                .padding(.top, 10)
                            Divider().frame(maxWidth: ScreenInfor().screenWidth - 60, maxHeight: 10)
                        }
                        
                        .onTapGesture {
                            userInformationViewModel.filter = item.id
                            if userInformationViewModel.curLocationText == "" {
                                userInformationViewModel.curLocationText = item.name }
                            else { userInformationViewModel.curLocationText = item.name + ", " + userInformationViewModel.curLocationText}
                        }
                    }
                }
                .onAppear {
                    LocationService().getAPI(userInformationViewModel.filter) { (data) in
                        self.data = data
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: ScreenInfor().screenWidth)
        .background(
            RoundedCornersShape(radius: 40, corners: [.topLeft, .topRight])
                .fill(Color.white)
        )
        .background(Rectangle()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: 50)
                        .foregroundColor(.white))
        
    }
    
    
    // Display content for typing
    var LocationTyperContent: some View {
        VStack (alignment: .center) {
            HStack {
                Button(action: {
                    userInformationViewModel.isPresentedLocationPickerView.toggle()
                    if userInformationViewModel.curLocationText != "" {
                        userInformationViewModel.locationText = userInformationViewModel.curLocationText
                    }
                }, label: {
                    Image(systemName: "xmark")
                })
                    .padding(.leading, 50)
                    .padding(.bottom, 15)
                
                Text("enter_address".localized)
                    .frame(width: ScreenInfor().screenWidth - 100, alignment: .center)
                    .padding(.trailing, 60)
                    .padding(.bottom, 15)
            }.padding(.top, 25)
//                .gesture(dragGesture)
            
            Divider()
            
            ZStack {
                TextField("location_example".localized, text: $typedText, onCommit:  {
                    if typedText != "" {
                        userInformationViewModel.curLocationText = typedText + ", " + userInformationViewModel.curLocationText
                    }
                    userInformationViewModel.isPresentedLocationPickerView.toggle()
                    
                    if userInformationViewModel.curLocationText != "" {
                        userInformationViewModel.locationText = userInformationViewModel.curLocationText
                    }
                })
                    .frame(width: ScreenInfor().screenWidth*0.85, height: 50)
                    .lineLimit(10)
            }
        }
        .frame(width: ScreenInfor().screenWidth, height: ScreenInfor().screenHeight*0.5, alignment: .top)
        .background(
            RoundedCornersShape(radius: 40, corners: [.topLeft, .topRight])
                .fill(Color.white)
        )
        .background(Rectangle()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: 50)
                        .foregroundColor(.white))
    }
}


struct LocationPickerPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerPopUpView()
            .environmentObject(UserInformationViewModel())
    }
}
