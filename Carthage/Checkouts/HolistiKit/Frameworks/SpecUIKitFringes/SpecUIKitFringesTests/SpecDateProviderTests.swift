import XCTest
@testable import SpecUIKitFringes

class SpecDateProviderTests: XCTestCase {

    var subject: SpecDateProvider!
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter
    }
    
    override func setUp() {
        super.setUp()
        subject = SpecDateProvider()
    }

    func test_initialDate() {
        let initialDateString = dateFormatter.string(from: subject.date)
        XCTAssertEqual(initialDateString, "2016-08-23 00:00:00 +0000")
    }

    func test_progressingTime() {
        subject.progress(seconds: 2)
        let dateString = dateFormatter.string(from: subject.date)
        XCTAssertEqual(dateString, "2016-08-23 00:00:02 +0000")
    }
}
