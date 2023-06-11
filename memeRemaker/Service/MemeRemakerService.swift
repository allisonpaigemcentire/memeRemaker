import Foundation
import UIKit

class MemeRemakerService {
    
    var session = URLSession.shared
    let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    
   
    internal func fetchMemeNames(url: URL) async throws -> [String] {
        
        let headers = [
           "X-RapidAPI-Key": apiKey,
           "X-RapidAPI-Host": "ronreiter-meme-generator.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let decoder = JSONDecoder()
        let (data, _) = try await session.data(for: request as URLRequest)
        return try decoder.decode(Array.self, from: data)
    }

    internal func fetchMemeNamesStream(url: URL) -> AsyncThrowingStream<String, Error> {
        
        let headers = [
           "X-RapidAPI-Key": apiKey,
           "X-RapidAPI-Host": "ronreiter-meme-generator.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

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
    }

    internal func fetchMemeImage(url: URL) async throws -> UIImage {
        
        let headers = [
           "X-RapidAPI-Key": apiKey,
           "X-RapidAPI-Host": "ronreiter-meme-generator.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
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
        
        // TO DO: if the meme text contains an apostrophe the service will fail but it works at https://rapidapi.com/meme-generator-api-meme-generator-api-default/api/meme-generator/. Solve and then remove the fallback
        
        guard let fallBackURL = URL(string: "https://ronreiter-meme-generator.p.rapidapi.com/meme?top=NO&bottom=APOSTROPHES&meme=\(imageName)&font_size=50&font=Impact") else {
            return URL(fileURLWithPath: "no path")
        }
        return fallBackURL
    }
    
    internal func fetchMemeImageWithCompletion(url: URL,
                                               completion: @escaping (((UIImage?)) -> ()))  {
        
        let headers = [
           "X-RapidAPI-Key": apiKey,
           "X-RapidAPI-Host": "ronreiter-meme-generator.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else { return }
            completion(UIImage(data: data))
        }
        task.resume()
    }

}
