//
//  memeRemakerViewModelTests.swift
//  memeRemakerViewModelTests
//
//  Created by Allison Mcentire on 9/5/22.

import XCTest
@testable import memeRemaker

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior

// Testing structure: Given, When, Then

class memeRemakerViewModelTests: XCTestCase {

    let SUT = MemeRemakerViewModel()
    
    
    func test_fetchMemeArray_onLoading_returnsArrayOfStrings() async throws {
        await SUT.getMemeNameArray()
        XCTAssertNotNil(SUT.memeNameArray)
        XCTAssertTrue(((SUT.memeNameArray?.contains("Condescending-Wonka")) != nil))
        XCTAssertTrue(SUT.memeNameArray?.count ?? 0 > 100)
    }
    
    func test_getMeme_expectedInputValues_generatesMemeImage() async throws {
        XCTAssertNil(SUT.generatedMeme)
        SUT.memeText = "Welcome to the Meme test"
        await SUT.getMemeNameArray()
        await SUT.getMeme()
        XCTAssertNotNil(SUT.generatedMeme)
    }
    
    func test_getMeme_unexpectedInputValues_generatesMemeImage() async throws {
        XCTAssertNil(SUT.generatedMeme)
        SUT.memeText = "(*&^%$#@#$%^&*&^%$#$%^&*&^%$#$%^"
        await SUT.getMemeNameArray()
        await SUT.getMeme()
        XCTAssertNotNil(SUT.generatedMeme)
    }
}

