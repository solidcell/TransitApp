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

    func testSecondLaunch() {
        tapAppIcon()
        forceKillApp()
        tapAppIcon()
        XCTAssertNotNil(mapUI)
    }
}
