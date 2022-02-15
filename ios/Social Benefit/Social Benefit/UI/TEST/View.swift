//
//  View.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 12/10/2021.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    func navController() -> SwipeNavigationController {
//        return UIApplication.shared.windows[0].rootViewController! as! SwipeNavigationController
//    }
//
//    var body: some View {
//        VStack {
//            Text("SwiftUI")
//                .onTapGesture {
//                    self.navController().pushSwipeBackView(A())
//            }
////        }.onAppear {
////            self.navController().navigationBar.topItem?.title = "Swift UI"
//        }.edgesIgnoringSafeArea(.top)
//    }
//}
//
//struct A: View {
//    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    var body: some View {
//        VStack {
//            Text("back")
//                .onTapGesture {
//                    self.presentationMode.wrappedValue.dismiss()
//                }
//            }
//        .navigationBarHidden(true)
//    }
//}
