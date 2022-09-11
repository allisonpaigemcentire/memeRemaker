//
//  MemeRemakerService.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/11/22.
//
import Combine
import Foundation
import UIKit

class MemeRemakerService {
    
    static func fetchMemeNames(url: URL) async throws -> Array<String> {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants().headers

        let session = URLSession.shared
        let decoder = JSONDecoder()
        let data = try await session.data(for: request as URLRequest)
        return try decoder.decode(Array.self, from: data.0)
    }
    
    static func fetchMemeImage(memeText: String, imageName: String) async throws -> UIImage {
        
        let url = generateRequestURL(memeText: memeText, imageName: imageName)
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants().headers

        let session = URLSession.shared
        do {
            let (data, _) = try await session.data(for: request as URLRequest)
            return UIImage(data: data) ?? UIImage()
        } catch {
            print(error)
        }
        
        return UIImage(systemName: "noproblem") ?? UIImage()
    }
    
    static func generateRequestURL(memeText: String, imageName: String) -> URL {
        let memeTextArray = memeText.components(separatedBy: " ")
        let chunks = memeTextArray.split()
        
        let top = chunks.left
        let bottom = chunks.right
        
        let topText = top.joined(separator: "%20")
        let bottomText = bottom.joined(separator: "%20")
        
        if let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?top=\(topText)&bottom=\(bottomText)&meme=\(imageName)&font_size=50&font=Impact") {
            return url
        }
        
        return URL(fileURLWithPath: "")
    }
   
}
