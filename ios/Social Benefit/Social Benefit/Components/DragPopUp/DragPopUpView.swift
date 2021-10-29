//
//  DragPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 05/10/2021.
//

import SwiftUI

struct DragPopUp: View {
    
    @State var curDragOffsetY: CGFloat = 0
    @Binding var isPresent: Bool
    
    var contentView: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresent {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        isPresent.toggle()
                    }
                
                LocationPickerView1(isPresent: $isPresent, curDragOffsetY: $curDragOffsetY, contentView: contentView)
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(.black)
    }
}

struct LocationPickerView1: View {

    @Binding var isPresent: Bool
    @Binding var curDragOffsetY: CGFloat
    
    var contentView: AnyView

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
            contentView
        }
        .offset(y: curDragOffsetY)
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
                    isPresent.toggle()
                }
                curDragOffsetY = 0
            }
        
    }
}

struct DragPopUp_Previews: PreviewProvider {
    static var previews: some View {
        DragPopUp(isPresent: .constant(true), contentView: AnyView(Text("123")))
    }
}
