import XCTest
@testable import NavigatorKit

final class NavigatorKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NavigatorKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
