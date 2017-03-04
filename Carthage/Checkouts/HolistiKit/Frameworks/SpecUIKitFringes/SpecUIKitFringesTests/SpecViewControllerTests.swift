import XCTest
@testable import SpecUIKitFringes

class SpecViewControllerTests: XCTestCase {

    var subject: RecordingSpecViewController!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecViewController()
    }

    func test_presentingAViewControllerCallsViewLifecycleMethods() {
        let presentedViewController = RecordingSpecViewController()
        subject.present(viewController: presentedViewController)
        XCTAssertEqual(subject.events, [ .viewWillDisappear, .viewDidDisappear ])
        XCTAssertEqual(presentedViewController.events, [ .viewDidLoad, .viewWillAppear, .viewDidAppear ])
    }

    func test_gettingTheNavigationController() {
        let navigationController = SpecNavigationController()
        XCTAssertNil(subject.navigationControlling)
        navigationController.push(viewController: subject, animated: true)
        XCTAssertNotNil(subject.navigationControlling)
    }
}
