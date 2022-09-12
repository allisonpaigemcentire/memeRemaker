//
//  ContentView.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MemeRemakerViewModel()
    
    init() {}
    
    var body: some View {
        VStack {
            Image(uiImage: ($viewModel.generatedMeme.wrappedValue ?? UIImage(named: "noproblem")) ?? UIImage())
                .resizable()
                .frame(minWidth: 0, idealWidth: UIScreen.main.bounds.width, maxWidth: 1000, minHeight: 0, idealHeight: UIScreen.main.bounds.height/2, maxHeight: 1000, alignment: .top)
                .scaledToFit()
                .padding()
            MemeTextField("Input Meme Text", text: $viewModel.memeText)
                .padding(.horizontal)
            Button("Generate Meme") {
                Task { await viewModel.getMeme() }
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
        }.onAppear {
            Task { await viewModel.getMemeNameArray() }
        }
    }
}
