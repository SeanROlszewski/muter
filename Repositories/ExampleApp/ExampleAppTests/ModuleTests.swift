import XCTest

class ModuleTests: XCTestCase {
    func test() {
        XCTAssert(areEqual(5, and: 5))
        XCTAssertFalse(areEqual(5, and: 6))
    }
}

class Module2Tests: XCTestCase {
    func test() {
        XCTAssertFalse(alwaysReturnsFalse())
    }
    
    func testAnother() {
        XCTAssert(shouldReturnTrue())
        XCTAssertFalse(shouldReturnTrue2())
    }
}
