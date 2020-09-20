import XCTest
@testable import SwiftTidy

final class SwiftTidyTests: XCTestCase {
    var document: Document!

    override func setUpWithError() throws {
        document = Document([
            "wrap": "0",
            "doctype": "omit",
            "show-body-only": "auto",
            "output-html": "yes"
        ])
    }

    func testClean_Should_NotChangeValidHtml() throws {
        let html = "<p>Hello World</p>"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<p>Hello World</p>")
    }

    func testClean_Should_FixMismatchTag() throws {
        let html = "<h2>subheading</h3>"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<h2>subheading</h2>")
    }

    func testClean_Should_CleanMisnestedTag() throws {
        let html = "<p>here is a para <b>bold <i>bold italic</b> bold?</i> normal?"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<p>here is a para <b>bold <i>bold italic</i></b> <i>bold?</i> normal?</p>")
    }

    func testClean_Should_MissingSlashInEndTag() throws {
        let html = "<a href=\"#refs\">References<a>"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<a href=\"#refs\">References</a>")
    }

    func testClean_Should_CleanList() throws {
        let html = "<li>1st list item<li>2nd list item"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<ul>\n<li>1st list item</li>\n<li>2nd list item</li>\n</ul>")
    }

    func testClean_Should_Attributes() throws {
        let html = "<img src=abc>"
        let cleaned = try document.clean(html)
        XCTAssertEqual(cleaned.trimmingCharacters(in: .whitespacesAndNewlines), "<img src=\"abc\">")
    }
}
