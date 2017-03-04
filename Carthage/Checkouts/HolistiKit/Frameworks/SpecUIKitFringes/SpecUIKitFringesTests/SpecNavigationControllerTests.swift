import XCTest
@testable import SpecUIKitFringes

class SpecNavigationControllerTests: XCTestCase {

    var subject: RecordingSpecNavigationController!
    
    override func setUp() {
        super.setUp()
        subject = RecordingSpecNavigationController()
    }

    func test_pushingTheFirstViewControllerCallsViewLifecycleMethods() {
        let viewController = RecordingSpecViewController()
        subject.push(viewController: viewController, animated: true)
        XCTAssertEqual(subject.events, [])
        XCTAssertEqual(viewController.events, [ .viewDidLoad, .viewWillAppear, .viewDidAppear ])
    }

    func test_pushingTheFirstViewControllerSetsTheTopViewController() {
        let viewController = RecordingSpecViewController()
        subject.push(viewController: viewController, animated: true)
        XCTAssertSame(subject.topViewController, viewController)
    }

    func test_pushingASubsequentViewControllerCallsViewLifecycleMethods() {
        let firstViewController = RecordingSpecViewController()
        let secondViewController = RecordingSpecViewController()
        subject.push(viewController: firstViewController, animated: true)
        XCTAssertEqual(subject.events, [])
        subject.push(viewController: secondViewController, animated: true)
        XCTAssertEqual(firstViewController.events, [ .viewDidLoad, .viewWillAppear, .viewDidAppear,
                                                     .viewWillDisappear, .viewDidDisappear ])
        XCTAssertEqual(secondViewController.events, [ .viewDidLoad, .viewWillAppear, .viewDidAppear ])
    }

    func test_pushingASubsequentViewControllerChangesTheTopViewController() {
        subject.push(viewController: SpecViewController(), animated: true)
        let viewController = RecordingSpecViewController()
        subject.push(viewController: viewController, animated: true)
        XCTAssertSame(subject.topViewController, viewController)
    }
}
