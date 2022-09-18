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
    
    let model: MemeRemakerViewModel = {
        let model = MemeRemakerViewModel()
        model.memeText = "Give me a meme"
        return model
    }()
    
    override func setUpWithError() throws {
        let testConfiguration = URLSessionConfiguration.default
        testConfiguration.protocolClasses = [TestURLProtocol.self]
        SUT.session = URLSession(configuration: testConfiguration)
    }

    // test will fail with error "Unexpected test scenario" because the function isn't an AsyncStream
//    func test_example_fail() async throws {
//        let url = SUT.generateRequestURL(memeText: model.memeText, imageName: "Condescending-Wonka")
//        let meme = try await SUT.fetchMemeImage(url: url)
//        XCTAssertNotNil(meme)
//    }
    
    func test_generateRequestURL_Returns_ExpectedURL() {
        let url = SUT.generateRequestURL(memeText: model.memeText, imageName: "Condescending-Wonka")
        XCTAssertEqual("https://ronreiter-meme-generator.p.rapidapi.com/meme?top=Give%20me&bottom=a%20meme&meme=Condescending-Wonka&font_size=50&font=Impact", url.absoluteString)
    }
}
