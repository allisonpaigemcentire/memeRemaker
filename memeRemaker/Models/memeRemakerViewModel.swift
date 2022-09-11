//
//  memeRemakerViewModel.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI
import Combine
import Foundation

class MemeRemakerViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    
    @Published var memeText: String = ""
    @Published var generatedMeme: UIImage?
    internal var memeNameArray: [String]?
    
    init() {
        
    }
   
    internal func getMemeNameArray() async {
        guard let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/images") else { return }
        
        do {
            memeNameArray = try await MemeRemakerService.fetchMemeNames(url: url)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    internal func getMeme() async {
        do {
        self.generatedMeme = try await MemeRemakerService.fetchMemeImage(memeText: memeText, imageName: memeNameArray?[Int.random(in: 1...999)] ?? "Condescending-Wonka")
        } catch {
            print(error)
        }
    }
}
