//
//  View.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = MyModel()
    
    var body: some View {
        
        VStack {
            
            RefreshableScrollView(height: 70, refreshing: self.$model.loading) {
                DogView(dog: self.model.dog).padding(30).background(Color.white)
                
            }.background(Color.green)
        }
    }
    
    
    struct DogView: View {
        let dog: Dog
        
        var body: some View {
            VStack {
                Image(dog.picture, defaultSystemImage: "questionmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .padding(2)
                    .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
                    .shadow(radius: 3)
                    .padding(4)
                
                Text(dog.name).font(.largeTitle).fontWeight(.bold)
                Text(dog.origin).font(.headline).foregroundColor(.blue)
                Text(dog.description)
                    .lineLimit(nil)
                    .frame(height: 1000, alignment: .top)
                    .padding(.top, 20)
            }
        }
    }
}

extension Image {
    init(_ name: String, defaultImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(defaultImage)
        }
    }
    
    init(_ name: String, defaultSystemImage: String) {
        if let img = UIImage(named: name) {
            self.init(uiImage: img)
        } else {
            self.init(systemName: defaultSystemImage)
        }
    }
    
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
