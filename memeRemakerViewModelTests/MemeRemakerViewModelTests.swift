import XCTest
@testable import memeRemaker

class MemeRemakerViewModelTests: XCTestCase {
    
    func test_memeNameArray_DoesNotIncludedDiscardedValues() async {
        let viewModel = MemeRemakerViewModel()
        let array = viewModel.memeNameArray
        Task {
            await viewModel.getMemeNameArray()
            XCTAssertEqual(array.count, 799)
            XCTAssertTrue(array.contains(MemeName(name: "Condescending-Wonka")))
            XCTAssertFalse(array.contains(MemeName(name: "Nickleback")))
        }
    }
    
    func test_getMeme() async {
        let viewModel = MemeRemakerViewModel()
        let meme = viewModel.generatedMeme
        XCTAssertNil(meme)
        Task {
            await viewModel.getMemeNameArray()
            await viewModel.getMeme()
            XCTAssertNotNil(meme)
        }
    }
    
    func test_getMemeReturns_ExpectedGeneratedMeme() async throws {
        let SUT = MemeRemakerViewModel()
        SUT.memeText = "Welcome to MemeRemaker"
        
        let expectedMeme = try await SUT.getGeneratedMeme(selection: "Aw-Yeah-Rage-Face")
        XCTAssertEqual(expectedMeme.memeText, SUT.memeText)
        XCTAssertNotNil(expectedMeme.memeImage)
    }
    
}
