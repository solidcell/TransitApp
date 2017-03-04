import XCTest
@testable import ExampleApp

class UIViewControllerTests: FringesTest {

    func test_titleIsCorrect() {
        tapAppIcon()
        examplesUI.tapUIViewControllerRow()
        XCTAssertEqual(uiViewControllerUI.title, "UIViewController")
    }

    func test_canPresentAViewController() {
        tapAppIcon()
        examplesUI.tapUIViewControllerRow()
        let vc = uiViewControllerUI
        uiViewControllerUI.tapPresentViewController()
        XCTAssertNotNil(vc?.presentedViewControlling)
    }
}
