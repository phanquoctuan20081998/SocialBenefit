//
//  RecognitionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/11/2021.
//

import SwiftUI

struct RecognitionView: View {
    @ObservedObject var recognitionViewModel = RecognitionViewModel()
    
    var body: some View {
        RecognitionNewsCardView(companyData: RecognitionData.sampleData[0], contentId: 8)
    }
}

struct RecognitionView_Previews: PreviewProvider {
    static var previews: some View {
        RecognitionView()
    }
}
