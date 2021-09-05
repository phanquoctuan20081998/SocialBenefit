//
//  BannerCurverShape.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/08/2021.
//

import SwiftUI

struct BannerCurveShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width - rect.height, y: 0))
            
            let to = CGPoint(x: rect.width, y: rect.height)
            let control = CGPoint(x: rect.width, y: 0)
            
            path.addQuadCurve(to: to, control: control)
            
        }
    }
}

struct BannerShapeView_Previews: PreviewProvider {
    static var previews: some View {
        Text("HAHAHAA")
            .frame(width: 100, height: 50)
            .background(Color.pink)
            .clipShape(BannerCurveShape())
    }
}



