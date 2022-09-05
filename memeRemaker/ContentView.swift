//
//  ContentView.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: MemeRemakerViewModel
    
    init(memeText: String) {
        _viewModel = StateObject(wrappedValue: MemeRemakerViewModel(memeText: memeText))
    }
    
    var body: some View {
        MemeTextField("Type something", text: $viewModel.memeText).padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(memeText: "Type something")
    }
}
