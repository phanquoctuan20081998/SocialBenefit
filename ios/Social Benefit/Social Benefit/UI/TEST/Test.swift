//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI

struct Test: View {
    
    let htmlString = "ddsc"
    
    var body: some View {
        VStack {
            HTMLText(html: htmlString)
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
