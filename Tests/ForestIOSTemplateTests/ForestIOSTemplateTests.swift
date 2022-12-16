import XCTest
@testable import ForestIOSTemplate

final class ForestIOSTemplateTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ForestIOSTemplate().text, "Hello, World!")
    }
    
    func testUI() {
        let app = XCUIApplication()
        app.launch()
    }
}
