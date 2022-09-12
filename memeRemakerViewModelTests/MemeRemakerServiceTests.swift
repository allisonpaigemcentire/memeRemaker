//
//  MemeRemakerServiceTests.swift
//  memeRemakerViewModelTests
//
//  Created by Allison Mcentire on 9/11/22.
//

import XCTest
@testable import memeRemaker

class MemeRemakerServiceTests: XCTestCase {
    
    func test_generateRequestURL_Returns_ExpectedURL() {
        let request = MemeRemakerService.generateRequestURL(memeText: "Give me a meme", imageName: "Condescending-Wonka")
        XCTAssertEqual("https://ronreiter-meme-generator.p.rapidapi.com/meme?top=Give%20me&bottom=a%20meme&meme=Condescending-Wonka&font_size=50&font=Impact", request.absoluteString)
    }

    func test() async {
        let request = MemeRemakerService.generateRequestURL(memeText: "Give me a meme", imageName: "Condescending-Wonka")
        do {
            let memeNameArray = try await MemeRemakerService.fetchMemeNames(url: request)
            XCTAssertTrue(memeNameArray.count > 100)
        } catch {
            XCTAssertNil(error)
        }
        
    }
}
