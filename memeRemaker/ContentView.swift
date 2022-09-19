//
//  ContentView.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MemeRemakerViewModel()
    @State private var selectedMeme: MemeName = MemeName(name: "Aw-Yeah-Rage-Face")
    
    var showPicker: Bool = false
    
    init(showPicker: Bool) {
        self.showPicker = showPicker
    }
    
    var body: some View {
        VStack {
            Image(uiImage: ($viewModel.generatedMeme.wrappedValue ?? UIImage(named: "noproblem")) ?? UIImage())
                .resizable()
                .frame(minWidth: 0, idealWidth: UIScreen.main.bounds.width, maxWidth: 1000, minHeight: 0, idealHeight: UIScreen.main.bounds.height/2, maxHeight: 1000, alignment: .top)
                .scaledToFit()
                .clipped()
                .padding()
            MemeTextField("Input Meme Text", text: $viewModel.memeText)
                .padding(.horizontal)
            if showPicker {
                Picker("Pick a meme", selection: $selectedMeme) {
                    ForEach(viewModel.memeNameArray, id: \.self) {
                        Text($0.name)
                    }
                }
                .padding()
                .pickerStyle(WheelPickerStyle())
            }
            Button("Generate Meme") {
                // how would we cancel this call if the view were to be dismissed?
                // https://www.hackingwithswift.com/quick-start/concurrency/how-to-cancel-a-task
                if showPicker {
                    Task { await viewModel.getMeme(selection: selectedMeme.name) }
                } else {
                    Task { await viewModel.getMeme() }
                }
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
        }.task {
            await viewModel.getMemeNameArray()
        }
    }
}
//
//Picker(selection: $selectedMeme, label: Text("Please choose a color")) {
//    ForEach(viewModel.memeNameArray) { memeName in
//            Text(memeName.name).tag(memeName.id)
//        }
//    }
