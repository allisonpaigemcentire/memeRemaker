//
//  memeRemakerViewModelTests.swift
//  memeRemakerViewModelTests
//
//  Created by Allison Mcentire on 9/5/22.
//

import XCTest
@testable import memeRemaker

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior

// Testing structure: Given, When, Then

class memeRemakerViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_MemeRemakerViewModel_memeText_textEqualsGivenValue() {
        // GIVEN
        let memeText: String = "testing this text"
        // WHEN
        let viewModel = MemeRemakerViewModel(memeText: memeText)
        // THEN
        XCTAssertEqual(viewModel.memeText, "testing this text")
    }
    
    func test_MemeRemakerViewModel_memeText_textIsEmpty() {
        // GIVEN
        let memeText: String = ""
        // WHEN
        let viewModel = MemeRemakerViewModel(memeText: memeText)
        // THEN
        XCTAssertTrue(viewModel.memeText.isEmpty)
    }
    
    func test_MemeRemakerViewModel_memeText_shouldBeInjectedValue_stressed() {
        
        for _ in 0..<100 {
            // GIVEN
            let memeText: String = UUID().uuidString
            // WHEN
            let viewModel = MemeRemakerViewModel(memeText: memeText)
            // THEN
            XCTAssertEqual(viewModel.memeText, memeText)
        }
    }
}
