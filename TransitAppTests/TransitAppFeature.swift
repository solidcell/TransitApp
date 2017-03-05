import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: XCTestCase {

    var window: SpecWindow!
    var dialogManager: SpecDialogManager!
    var settingsApp: SpecSettingsApp!
    var dateProvider: SpecDateProvider!
    var urlSession: SpecURLSession!

    override func setUp() {
        super.setUp()

        window = SpecWindow()
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
        let appCoordinator = AppCoordinator(mapViewFactory: mapViewFactory,
                                            urlSession: urlSession,
                                            timerFactory: timerFactory,
                                            locationManagerFactory: locationManagerFactory)
        appCoordinator.didFinishLaunching(withWindow: window)
    }

    var mapView: SpecMapView { return window.topViewController as! SpecMapView }
}
