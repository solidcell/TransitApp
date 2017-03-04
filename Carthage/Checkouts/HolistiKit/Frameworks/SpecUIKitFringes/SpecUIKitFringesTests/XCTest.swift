import XCTest

func XCTAssertSame<T: AnyObject>(_ object: T, _ otherObject: T,
                   file: StaticString = #file, line: UInt = #line) {
    if object !== otherObject {
        XCTFail("XCTAssetSame: (\(object)) is not the same object as (\(otherObject)) -", file: file, line: line)
    }
}

func XCTAssertNotSame<T: AnyObject>(_ object: T, _ otherObject: T,
                      file: StaticString = #file, line: UInt = #line) {
    if object === otherObject {
        XCTFail("XCTAssetNotSame: (\(object)) is the same object as (\(otherObject)) -", file: file, line: line)
    }
}
