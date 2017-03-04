import XCTest
@testable import SpecUIKitFringes

class SpecTimeZoneProviderTests: XCTestCase {

    var subject: SpecTimeZoneProvider!

    override func setUp() {
        super.setUp()
        subject = SpecTimeZoneProvider()
    }

    func test_initialTimeZone() {
        XCTAssertEqual(subject.timeZone, TimeZone(abbreviation: "BRT")!)
    }

    func test_changingTimeZone() {
        subject.timeZone = TimeZone(abbreviation: "PST")!
        XCTAssertEqual(subject.timeZone, TimeZone(abbreviation: "PST"))
    }
}
