//
//  memeRemakerViewModel.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//

import SwiftUI
import Foundation


class MemeRemakerViewModel: ObservableObject {
    
    @Published var memeNameArray = [MemeName(name: "Aw-Yeah-Rage-Face")]
    @Published var memeText: String = ""
    @Published var generatedMeme: UIImage?
    internal var memeContainer: GeneratedMeme?
    
    let memeRemakerService = MemeRemakerService()
    let memes = Memes()
    
    init() {}

    internal func getMemeNameArray() async {
        guard let url = URL(string: Constants.nameArray) else { return }
        
        do {
            for try await name in memeRemakerService.fetchMemeNamesStream(url: url) {
                if !memes.discardedMemeArray.contains(name) {
                    memeNameArray.append(MemeName(name: name))
                }
            }
        } catch {
            print(error)
        }
        
    }

    internal func getMeme(selection: String? = nil) async {
        Task {
            let count = memeNameArray.count - 1
            
            let url = memeRemakerService.generateRequestURL(memeText: memeText, imageName: selection ?? memeNameArray[Int.random(in: 1...count)].name)
            do {
                let imageResponse = try await memeRemakerService.fetchMemeImage(url: url)
                let generatedMeme = GeneratedMeme(memeImage: imageResponse, memeText: memeText, timeStamp: Date())
                self.generatedMeme = generatedMeme.memeImage
            } catch {
                print(error)
            }
        }
    }
    
    internal func getGeneratedMeme(selection: String? = nil) async throws -> GeneratedMeme {
        let count = memeNameArray.count - 1
        let url = memeRemakerService.generateRequestURL(memeText: memeText, imageName: selection ?? memeNameArray[Int.random(in: 1...count)].name)
        let imageResponse = try await memeRemakerService.fetchMemeImage(url: url)
        return GeneratedMeme(memeImage: imageResponse, memeText: memeText, timeStamp: Date())
    }
}
