import XCTest

class OnboardingFeature: TransitAppFeature {

    func testFirstLaunch() {
        tapAppIcon()
        XCTAssertNotNil(onboardingUI)
    }

    func testSkipOnboarding() {
        tapAppIcon()
        onboardingUI.tapSkip()
        XCTAssertNotNil(mapUI)
    }
}
