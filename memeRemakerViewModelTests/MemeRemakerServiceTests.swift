//
//  MemeRemakerServiceTests.swift
//  memeRemakerViewModelTests
//
//  Created by Allison Mcentire on 9/11/22.
//

import XCTest
@testable import memeRemaker

class MemeRemakerServiceTests: XCTestCase {
    
    let SUT = MemeRemakerService()
    
    

    func test_fetchMemeNamesStream_fetches_ExpectedName() async throws {
        let expectation = self.expectation(description: "Name received.")
        
        guard let url = URL(string: Constants.nameArray) else { return }
        let asyncSequenceTask = Task {
            for try await name in SUT.fetchMemeNamesStream(url: url) {
                if name == "confession-kid" {
                    expectation.fulfill()
                }
            }
        }
        await waitForExpectations(timeout: 10)
        asyncSequenceTask.cancel()
    }
    
    
    @MainActor func test_generateRequestURL_Returns_ExpectedURL() {
        let url = SUT.generateRequestURL(memeText: "Give me a meme", imageName: "Condescending-Wonka")
        XCTAssertEqual("https://ronreiter-meme-generator.p.rapidapi.com/meme?top=Give%20me&bottom=a%20meme&meme=Condescending-Wonka&font_size=50&font=Impact", url.absoluteString)
    }
}
