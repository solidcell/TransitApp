import XCTest
import UIKitFringes
@testable import SpecUIKitFringes

class SpecLocationManagerTestCase: XCTestCase {

    var subject: LocationManaging!
    var factory: SpecLocationManagerFactory!
    var delegate: SpecLocationManagerDelegate!
    var dialogManager: SpecDialogManager!
    var errorHandler: SpecErrorHandler!
    var settingsApp: SpecSettingsApp!
    var userLocation: SpecUserLocation!
    
    override func setUp() {
        super.setUp()

        let locationServices = SpecLocationServices()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        settingsApp = SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                                      locationServices: locationServices)
        errorHandler = SpecErrorHandler()
        dialogManager = SpecDialogManager(errorHandler: errorHandler)
        userLocation = SpecUserLocation()
        factory = SpecLocationManagerFactory(dialogManager: dialogManager,
                                             errorHandler: errorHandler,
                                             userLocation: userLocation,
                                             locationServices: locationServices,
                                             locationAuthorizationStatus: locationAuthorizationStatus)
        subject = factory.create()
        delegate = SpecLocationManagerDelegate()
        subject.delegate = delegate
    }
}
