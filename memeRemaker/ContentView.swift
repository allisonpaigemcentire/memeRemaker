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
                .frame(width: UIScreen.main.bounds.width, height: 500, alignment: .topLeading)
                .clipped()
                .padding()
            MemeTextField("Input Meme Text", text: $viewModel.memeText)
                .padding(.horizontal)
            Button("Generate Meme") {
                Task {
                    await viewModel.getMeme()
                }
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
        }
    }
}
