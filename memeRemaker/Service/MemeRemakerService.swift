//
//  MemeRemakerService.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/11/22.
//
import Foundation
import UIKit

class MemeRemakerService {
    
    var session = URLSession.shared
    
    internal func fetchMemeNames(url: URL) async throws -> [String] {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers

        let decoder = JSONDecoder()
        let (data, _) = try await session.data(for: request as URLRequest)
        return try decoder.decode(Array.self, from: data)
    }
    
    // TO DO:
    // write a function that excludes some of the images
    // filter the array on that function
    
    internal func fetchMemeNamesStream(url: URL) -> AsyncThrowingStream<String, Error> {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers

        let decoder = JSONDecoder()
        
        return AsyncThrowingStream<String, Error> { continuation in
            Task {
                
                do {
                    let (data, _) = try await session.data(for: request as URLRequest)
                    for name in try decoder.decode(Array<String>.self, from: data) {
                        continuation.yield(name)
                    }
                    
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
        
       // let (data, _) = try await session.data(for: request as URLRequest)
       // return try decoder.decode(Array.self, from: data)
    }

    internal func fetchMemeImage(url: URL) async throws -> UIImage {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = Constants.headers

        
        do {
            let (data, _) = try await session.data(for: request as URLRequest)
            return UIImage(data: data) ?? UIImage()
        } catch {
            print(error)
        }
        
        return UIImage(systemName: "noproblem") ?? UIImage()
    }
    
    internal func generateRequestURL(memeText: String, imageName: String) -> URL {
        let memeTextArray = memeText.components(separatedBy: " ")
        let chunks = memeTextArray.split()
        
        let top = chunks.left
        let bottom = chunks.right
        
        let topText = top.joined(separator: "%20")
        let bottomText = bottom.joined(separator: "%20")
        
        if let url = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?top=\(topText)&bottom=\(bottomText)&meme=\(imageName)&font_size=50&font=Impact") {
            return url
        }
        
        // if the meme text contains an apostrophe the service will fail but it works at https://rapidapi.com/meme-generator-api-meme-generator-api-default/api/meme-generator/ so I'm not sure why yet
        
        guard let fallBackURL = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?top=NO&bottom=APOSTROPHES&meme=\(imageName)&font_size=50&font=Impact") else {
            return URL(fileURLWithPath: "no path")
        }
        return fallBackURL
    }

}
