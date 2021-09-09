//
//  LocationPickerPopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/08/2021.
//

import SwiftUI
import Alamofire

struct LocationPickerPopUpView: View {
    
    @State var curDragOffsetY: CGFloat = 0
    
    @Binding var isPresented: Bool //Show popup or not
    @Binding var endDragOffsetY: CGFloat
    @Binding var filter: String //Chosse City, Ward, ...
    @Binding var text: String
    @Binding var curText: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresented {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        isPresented.toggle()
                        if curText != "" {
                            text = curText
                        }
                    }
                LocationPickerView(text: $text, curText: $curText, isPresented: $isPresented, curDragOffsetY: $curDragOffsetY, endDragOffsetY: $endDragOffsetY, filter: $filter)
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
    }
}

struct LocationPickerView: View {
    
    @State var data: [LocationData] = []
    @State var typedText = ""
    
    @Binding var text: String
    @Binding var curText: String
    @Binding var isPresented: Bool //Show popup or not
    @Binding var curDragOffsetY: CGFloat
    @Binding var endDragOffsetY: CGFloat
    @Binding var filter: String //Chosse City, Ward, ...
    
    var body: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 45, height: 6)
                    .foregroundColor(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 20)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            Spacer().frame(height: 0)
            
            if filter.count == 0 {
                LocationPickerContent
            } else if filter.count == 2 {
                LocationPickerContent
            } else if filter.count == 3 {
                LocationPickerContent
            } else {
                LocationTyperContent
            }
        }
        .offset(y: curDragOffsetY)
        .offset(y: endDragOffsetY)
        
    }
    
    // Display content for picking
    var LocationPickerContent: some View {
        VStack (alignment: .center) {
            HStack {
                Button(action: {
                    isPresented.toggle()
                    if curText != "" {
                        text = curText
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
            .gesture(dragGesture)
            
            Divider()
            
            ScrollView(.vertical) {
                ForEach(data, id: \.self) { item in
                    
                    Button(action: {
                        filter = item.id
                        
                        if curText == "" {
                            curText = item.name
                        } else {
                            curText = item.name + ", " + curText
                        }
                    }, label: {
                        VStack {
                            Text(item.name)
                                .frame(width: ScreenInfor().screenWidth - 70, height: 30, alignment: .leading)
                                .padding(.top, 10)
                            Divider().frame(maxWidth: ScreenInfor().screenWidth - 60, maxHeight: 10)
                        }
                    })
                }
                .onAppear {
                    LocationService().getAPI(filter) { (data) in
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
                    isPresented.toggle()
                    if curText != "" {
                        text = curText
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
            .gesture(dragGesture)
            
            Divider()
            
            ZStack {
                TextField("location_example".localized, text: $typedText, onCommit:  {
                    if typedText != "" {
                        curText = typedText + ", " + curText
                    }
                    isPresented.toggle()
                    
                    if curText != "" {
                        text = curText
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
    
    
    // Drag Gesture define
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { val in

                    curDragOffsetY = val.translation.height
                    if curDragOffsetY < 0 {
                        curDragOffsetY = 0
                    }
                
            }
            .onEnded { val in
                
                    if curDragOffsetY > 150 {
                        isPresented.toggle()
                        if curText != "" {
                            text = curText
                        }
                    }
                    curDragOffsetY = 0
                }
            
    }
}


struct LocationPickerPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerPopUpView(isPresented: .constant(true), endDragOffsetY: .constant(0), filter: .constant("544444"), text: .constant(""), curText: .constant(""))
    }
}
