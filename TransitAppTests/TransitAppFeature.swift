import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: XCTestCase {

    // Let the object graph hold onto this, so as not to
    // mask possible retain issues
    weak var locationManager: SpecLocationManager!
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
        let _locationManager = SpecLocationManager(dialogManager: dialogManager,
                                                   userLocation: userLocation,
                                                   locationServices: locationServices,
                                                   locationAuthorizationStatus: locationAuthorizationStatus)
        locationManager = _locationManager
        let mapViewFactory = SpecMapViewFactory()
        subject = AppCoordinator()
        subject.start(window: UIWindow(),
                      mapViewFactory: mapViewFactory,
                      urlSession: urlSession,
                      timerFactory: timerFactory,
                      locationManager: locationManager)
        mapView = mapViewFactory.mapView
    }
}
