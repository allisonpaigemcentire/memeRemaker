import XCTest
@testable import memeRemaker

class MemeRemakerViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
   
    func test_memeNameArray_DoesNotIncludedDiscardedValues() async {
        let viewModel = await MemeRemakerViewModel()
        let array = await viewModel.memeNameArray
        Task {
            await viewModel.getMemeNameArray()
            XCTAssertEqual(array.count, 799)
            XCTAssertTrue(array.contains(MemeName(name: "Condescending-Wonka")))
            XCTAssertFalse(array.contains(MemeName(name: "Nickleback")))
        }
    }
    
    func test_getMeme() async {
        let viewModel = await MemeRemakerViewModel()
        let meme = await viewModel.generatedMeme
        XCTAssertNil(meme)
        Task {
            await viewModel.getMemeNameArray()
            await viewModel.getMeme()
            XCTAssertNotNil(meme)
        }
    }
    
}
