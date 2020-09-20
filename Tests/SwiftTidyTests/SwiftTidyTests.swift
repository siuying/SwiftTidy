import XCTest
@testable import SwiftTidy

final class SwiftTidyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Document().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
