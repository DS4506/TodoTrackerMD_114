
#if canImport(XCTest)
import XCTest

final class TodoApp2UITest: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.state == .runningForeground || app.state == .runningBackground)
    }
}
#else
struct _NoopUITests { }
#endif
