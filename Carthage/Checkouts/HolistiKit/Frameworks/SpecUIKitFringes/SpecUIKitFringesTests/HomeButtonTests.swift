import XCTest
@testable import SpecUIKitFringes

class HomeButtonTests: SpecSystemTestCase {

    func test_tappingOnTheHomeInTheSpringBoard() {
        subject.tapHomeButton()
        XCTAssertNil(appDelegate)
    }

    func test_doubleTappingOnTheHomeButtonInTheSpringBoard() {
        subject.doubleTapHomeButton()
        XCTAssertNil(appDelegate)
    }

    func test_tappingOnTheHomeButtonInTheApp() {
        subject.tapAppIcon()
        appDelegate.clearEvents()
        subject.tapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationWillResignActive, .applicationDidEnterBackground ])
    }

    func test_doubleTappingOnTheHomeButtonInTheApp() {
        subject.tapAppIcon()
        appDelegate.clearEvents()
        subject.doubleTapHomeButton()
        XCTAssertEqual(appDelegate.events, [ .applicationWillResignActive ])
    }
}
