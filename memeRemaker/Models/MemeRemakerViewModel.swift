//
//  memeRemakerViewModel.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI
import Foundation

class MemeRemakerViewModel: ObservableObject {

    @Published var memeText: String = ""
    @Published var generatedMeme: UIImage?
    internal var memeNameArray: [String]?
    
    let memeRemakerService = MemeRemakerService()
    
    init() {
        
    }
   
    internal func getMemeNameArray() async {
        guard let url = URL(string: Constants.nameArray) else { return }
        
        do {
            for try await name in memeRemakerService.fetchMemeNamesStream(url: url) {
                memeNameArray?.append(name)
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    internal func getMeme() async {
        
        let url = memeRemakerService.generateRequestURL(memeText: memeText, imageName: memeNameArray?[Int.random(in: 1...999)] ?? "Condescending-Wonka")
        
        do {
            let imageResponse = try await memeRemakerService.fetchMemeImage(url: url)
            let generatedMeme = GeneratedMeme(memeImage: imageResponse, memeText: memeText, timeStamp: Date())
            
            self.generatedMeme = generatedMeme.memeImage
        } catch {
            print(error)
        }
    }
}
