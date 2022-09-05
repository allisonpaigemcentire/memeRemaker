//
//  MemeRemakerService.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/11/22.
//
import Combine
import Foundation
import Algorithms
import UIKit

class MemeRemakerService {
    
    static func fetchMemeNames(url: URL) async throws -> Array<String> {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants().headers

        let session = URLSession.shared
        let decoder = JSONDecoder()
        let (data, response) = try await session.data(for: request as URLRequest)
        print("response", response)
        
        return try decoder.decode(Array.self, from: data)
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
        let chunks = memeTextArray.chunks(ofCount: memeTextArray.count/2)
        
        let top = chunks.first
        let bottom = chunks.last
        
        let topText = top?.joined(separator: "%20") ?? ""
        let bottomText = bottom?.joined(separator: "%20") ?? ""
        
        if let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?top=\(topText)&bottom=\(bottomText)&meme=\(imageName)&font_size=75&font=Impact") {
            return url
        }
        
        return URL(fileURLWithPath: "")
    }
   
}
