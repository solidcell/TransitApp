import XCTest
@testable import SpecUIKitFringes

class SpecWindowTests: XCTestCase {

    var subject: SpecWindow!
    
    override func setUp() {
        super.setUp()
        subject = SpecWindow()
    }

    func test_settingRootViewControllerCallsViewLifecycleMethods() {
        let viewController = RecordingSpecViewController()
        subject.set(rootViewController: viewController)
        XCTAssertEqual(viewController.events, [ .viewDidLoad, .viewWillAppear, .viewDidAppear ])
    }
}
