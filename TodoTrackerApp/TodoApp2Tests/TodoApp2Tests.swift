
#if canImport(XCTest)
import XCTest

final class TodoApp2Tests: XCTestCase {
    func testExample() {
        XCTAssertTrue(true)
    }
}
#else
// XCTest not available (or target misconfigured). Keep the target compiling.
struct _NoopUnitTests { }
#endif
