import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: XCTestCase {

    private var system: TransitAppSpecSystem!
    
    override func setUp() {
        super.setUp()
        system = TransitAppSpecSystem()
    }
    
    func tapAppIcon() { system.tapAppIcon() }
    func doubleTapHomeButton() { system.doubleTapHomeButton() }
    func swipeUpAppScreenshot() { system.swipeUpAppScreenshot() }
    func tapHomeButton() { system.tapHomeButton() }
    func forceKillApp() {
        doubleTapHomeButton()
        swipeUpAppScreenshot()
        tapHomeButton()
    }
    
    func tapAppIconAndSkipToMap() {
        tapAppIcon()
        onboardingUI.tapSkip()
    }

    var urlSession: SpecURLSession { return system.urlSession }
    var dateProvider: SpecDateProvider { return system.dateProvider }
    var dialogManager: SpecDialogManager { return system.dialogManager }
    var settingsApp: SpecSettingsApp { return system.settingsApp }
    var location: SpecSystem.Location { return system.location }
    
    private var window: UIWindow { return system.appDelegate.window! }
    private var topmostViewController: UIViewController? { return window.topmostViewController }
    var onboardingUI: OnboardingUI! { return topmostViewController as? OnboardingUI }
    var mapUI: MapUI! { return topmostViewController as? MapUI }
    var alertUI: UIAlertController! { return topmostViewController as? UIAlertController }
}
