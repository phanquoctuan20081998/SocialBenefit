//
//  DatePickerPopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/08/2021.
//

import SwiftUI

struct DatePickerPopupView: View {
    
    @Binding var isPresented: Bool
    @Binding var isChanged: Bool
    @Binding var selectedDate: Date
    @Binding var currentDate: Date
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        isPresented = false
                    }
                DataPickerView
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
//        .edgesIgnoringSafeArea(.all)
    }
    
    var DataPickerView: some View {
        VStack (alignment: .center) {
            HStack {
                Button(action: {
                    selectedDate = currentDate
                    isPresented = false
                }, label: {
                    Image(systemName: "xmark")
                })
                .padding(.leading, 50)
                .padding(.bottom, 15)
                
                Text("select_date".localized)
                    .frame(width: ScreenInfor().screenWidth - 100, alignment: .center)
                    .padding(.trailing, 60)
                    .padding(.bottom, 15)
            }.padding(.top, 10)
            
            Divider()
            
            DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date) .datePickerStyle(WheelDatePickerStyle())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(.trailing, (ScreenInfor().screenWidth - 306)/2)
            
            
            Button(action: {
                isChanged = true
                currentDate = selectedDate
                isPresented = false
            }, label: {
                Text("done".localized)
                    .frame(width: ScreenInfor().screenWidth - 30*2, height: 50)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(16)
            })
            
        }
        .frame(width: ScreenInfor().screenWidth, height: 360)
        .background(Color.white)
        .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
        .background(Rectangle()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: 50)
                        .foregroundColor(.white))
    }
}

struct DatePickerPopupView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerPopupView(isPresented: .constant(true), isChanged: .constant(false), selectedDate: .constant(Date()), currentDate: .constant(Date()))
        //            .previewLayout(.sizeThatFits)
    }
}
