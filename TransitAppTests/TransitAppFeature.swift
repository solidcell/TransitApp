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

    var urlSession: SpecURLSession { return system.urlSession }
    var dateProvider: SpecDateProvider { return system.dateProvider }
    var dialogManager: SpecDialogManager { return system.dialogManager }
    var settingsApp: SpecSettingsApp { return system.settingsApp }
    var location: SpecSystem.Location { return system.location }
    
    private var window: UIWindow { return system.appDelegate.window! }
    var mapUI: MapUI! { return window.topmostViewController as? MapUI }
    var alertUI: UIAlertController! { return window.topmostViewController as? UIAlertController }
}
