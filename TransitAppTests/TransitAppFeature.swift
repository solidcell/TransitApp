import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: TransitAppSpec {

    // Let the object graph hold onto this, so as not to
    // mask possible retain issues
    weak var locationManager: SpecLocationManager!
    // Hold onto these, as the AppDelegate and UIKit would
    var subject: MainCoordinator!
    var mapView: SpecMapViewInterating!
    var dialogManager: SpecDialogManager!
    var settingsApp: SpecSettingsApp!
    var dateProvider: SpecDateProvider!
    var urlSession: SpecURLSession!

    override func setUp() {
        super.setUp()

        urlSession = SpecURLSession()
        dateProvider = SpecDateProvider()
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
        dialogManager = SpecDialogManager()
        let locationServices = SpecLocationServices()
        let userLocation = SpecUserLocation()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        settingsApp = SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                                      locationServices: locationServices)
        let _locationManager = SpecLocationManager(dialogManager: dialogManager,
                                                   userLocation: userLocation,
                                                   locationServices: locationServices,
                                                   locationAuthorizationStatus: locationAuthorizationStatus)
        locationManager = _locationManager
        let mapViewFactory = SpecMapViewFactory()
        subject = MainCoordinator()
        subject.start(window: UIWindow(),
                      mapViewFactory: mapViewFactory,
                      realm: realm,
                      urlSession: urlSession,
                      timerFactory: timerFactory,
                      locationManager: locationManager)
        mapView = mapViewFactory.mapView
    }
}
