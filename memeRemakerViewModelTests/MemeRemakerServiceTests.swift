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
        let url = MemeRemakerService.generateRequestURL(memeText: "Give me a meme", imageName: "Condescending-Wonka")
        XCTAssertEqual("https://ronreiter-meme-generator.p.rapidapi.com/meme?top=Give%20me&bottom=a%20meme&meme=Condescending-Wonka&font_size=50&font=Impact", url.absoluteString)
    }

    func test_fetchMemeNames_Throws_Error() async {
        let url = MemeRemakerService.generateRequestURL(memeText: "Give me a meme", imageName: "Condescending-Wonka")
        do {
            _ = try await MemeRemakerService.fetchMemeNames(url: url)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
