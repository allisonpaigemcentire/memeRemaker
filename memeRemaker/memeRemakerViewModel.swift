//
//  memeRemakerViewModel.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI

class MemeRemakerViewModel: ObservableObject {
    
    @Published var memeText: String
    
    init(memeText: String) {
        self.memeText = memeText
    }
}
