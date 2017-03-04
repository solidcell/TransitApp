import XCTest
@testable import SpecUIKitFringes

class SpecSharedApplicationTests: XCTestCase {

    var subject: SpecSharedApplication!
    
    override func setUp() {
        super.setUp()
        subject = SpecSharedApplication()
    }

    func test_isNetworkActivityIndicatorVisibleStartsAsFalse() {
        XCTAssertFalse(subject.isNetworkActivityIndicatorVisible)
    }
}
