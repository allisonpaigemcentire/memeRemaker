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
    
    let memeRemakerService = MemeRemakerService()
    let memes = Memes()
    var testSession = URLSession.shared
    
    init() {}
    
    @MainActor
    func postNewMemeToArchive(fileName: String) async throws {
        
       // let path = memeRemakerService.getFilePath(fileName: fileName)
        let headers = ["Content-Type": "application/json"]
        
        guard let url = URL(string: "http://localhost:8080/info") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try JSONEncoder().encode(
            InfoData(name: fileName)
        )

        let (_, response) = try await testSession.data(for: request as URLRequest, delegate: nil)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          throw "trm the server responded with an error."
        }
    }

    
    internal func getMemeNameArray() async {
        guard let url = URL(string: Constants.nameArray) else { return }
        
        do {
            for try await name in memeRemakerService.fetchMemeNamesStream(url: url) {
                if !memes.discardedMemeArray.contains(name) {
                    await MainActor.run {
                        memeNameArray.append(MemeName(name: name))
                    }
                   // try await postNewMemeToArchive(fileName: name)
                }
            }
        } catch {
            print(error)
        }
    }
    
    internal func getMemeNameArrayStreamless() async {
        guard let url = URL(string: Constants.nameArray) else { return }
        
        do {
            let memeNames = try await memeRemakerService.fetchMemeNames(url: url)
            memeNames.forEach { name in
                if !memes.discardedMemeArray.contains(name) {
                    memeNameArray.append(MemeName(name: name))
                }
            }
        } catch {
            print(error)
        }
    }

    internal func getMeme() async {
        let count = memeNameArray.count - 1
        
        let url = memeRemakerService.generateRequestURL(memeText: memeText, imageName: memeNameArray[Int.random(in: 1...count)].name)
        do {
            let imageResponse = try await memeRemakerService.fetchMemeImage(url: url)
            let generatedMeme = GeneratedMeme(memeImage: imageResponse, memeText: memeText, timeStamp: Date())
            await MainActor.run {
                self.generatedMeme = generatedMeme.memeImage
            }
        } catch {
            print(error)
        }
    }
    
    internal func getGeneratedMeme(selection: String?) async throws -> GeneratedMeme {
        let count = memeNameArray.count - 1
        
        let url = memeRemakerService.generateRequestURL(memeText: memeText, imageName: selection ?? memeNameArray[Int.random(in: 1...count)].name)
        
        let imageResponse = (try? await memeRemakerService.fetchMemeImage(url: url)) ?? UIImage()
        return GeneratedMeme(memeImage: imageResponse, memeText: memeText, timeStamp: Date())
    }
    
    internal func getRandomMeme() -> GeneratedMeme? {
        guard let url = URL(string: Constants.nameArray) else { return nil }
        let imageURL = memeRemakerService.generateRequestURL(memeText: memeText, imageName: "Aw-Yeah-Rage_Face")
                                                             
        Task {
            async let memeNameArray = memeRemakerService.fetchMemeNames(url: url)
            async let memeImage = memeRemakerService.fetchMemeImage(url: imageURL)
            
            return try await GeneratedMeme(memeImage: memeImage, memeText: memeNameArray.last ?? "test", timeStamp: Date())
        }
        return nil
    }
    
    func callFunction() {
        let meme = getRandomMeme()
    }}
