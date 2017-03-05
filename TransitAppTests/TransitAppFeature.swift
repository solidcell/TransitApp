import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: XCTestCase {

    // Hold onto these, as the AppDelegate and UIKit would
    var subject: AppCoordinator!
    var mapView: SpecMapViewInterating!
    var dialogManager: SpecDialogManager!
    var settingsApp: SpecSettingsApp!
    var dateProvider: SpecDateProvider!
    var urlSession: SpecURLSession!

    override func setUp() {
        super.setUp()

        urlSession = SpecURLSession()
        dateProvider = SpecDateProvider()
        dialogManager = SpecDialogManager()
        let locationServices = SpecLocationServices()
        let userLocation = SpecUserLocation()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        settingsApp = SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                                      locationServices: locationServices)
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
        let locationManagerFactory = SpecLocationManagerFactory(dialogManager: dialogManager,
                                                                userLocation: userLocation,
                                                                locationServices: locationServices,
                                                                locationAuthorizationStatus: locationAuthorizationStatus)
        let mapViewFactory = SpecMapViewFactory()
        subject = AppCoordinator()
        subject.start(window: UIWindow(),
                      mapViewFactory: mapViewFactory,
                      urlSession: urlSession,
                      timerFactory: timerFactory,
                      locationManagerFactory: locationManagerFactory)
        mapView = mapViewFactory.mapView
    }
}
