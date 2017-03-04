import XCTest
import UIKitFringes
@testable import SpecUIKitFringes

class SpecScheduledTimerTests: XCTestCase {

    var subject: Timing!
    var dateProvider: SpecDateProvider!
    
    override func setUp() {
        super.setUp()
        dateProvider = SpecDateProvider()
        let factory = SpecTimerFactory(dateProvider: dateProvider)
        subject = factory.create()
    }

    func test_firesAtAnInterval() {
        var firedCount = 0
        dateProvider.progress(seconds: 1)
        subject.start(interval: 2, repeats: true) { firedCount += 1 }
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 1)
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 1)
        XCTAssertEqual(firedCount, 1)
        dateProvider.progress(seconds: 2)
        XCTAssertEqual(firedCount, 2)
    }

    func test_firesMultipleTimesIfTimeProgressionIsLongEnough() {
        var firedCount = 0
        subject.start(interval: 2, repeats: true) { firedCount += 1 }
        XCTAssertEqual(firedCount, 0)
        dateProvider.progress(seconds: 4)
        XCTAssertEqual(firedCount, 2)
    }
}
