import XCTest
import SpecUIKitFringes
@testable import TransitApp

class TransitAppFeature: TransitAppSpec {

    var scooterUpdater: SpecScooterUpdater!
    // Let the object graph hold onto this, so as not to
    // mask possible retain issues
    weak var locationManager: SpecLocationManager!
    // Hold onto these, as the AppDelegate and UIKit would
    var subject: MainCoordinator!
    var mapView: SpecMapViewInterating!
    var dialogManager: SpecDialogManager!
    var settingsApp: SpecSettingsApp!

    override func setUp() {
        super.setUp()

        let scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
        let jsonFetcher = SpecJSONFetcher()
        let fetchTimer = SpecFetchTimer()
        self.scooterUpdater = SpecScooterUpdater(scooterRealmNotifier: scooterRealmNotifier,
                                                 jsonFetcher: jsonFetcher,
                                                 fetchTimer: fetchTimer)
        self.dialogManager = SpecDialogManager()
        let locationServices = SpecLocationServices()
        let userLocation = SpecUserLocation()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        self.settingsApp = SpecSettingsApp(locationAuthorizationStatus: locationAuthorizationStatus,
                                           locationServices: locationServices)
        let _locationManager = SpecLocationManager(dialogManager: self.dialogManager,
                                                   userLocation: userLocation,
                                                   locationServices: locationServices,
                                                   locationAuthorizationStatus: locationAuthorizationStatus)
        self.locationManager = _locationManager
        let mapViewFactory = SpecMapViewFactory()
        self.subject = MainCoordinator()
        self.subject.start(window: UIWindow(),
                           mapViewFactory: mapViewFactory,
                           realm: self.realm,
                           scooterRealmNotifier: scooterRealmNotifier,
                           jsonFetcher: jsonFetcher,
                           fetchTimer: fetchTimer,
                           locationManager: self.locationManager)
        self.mapView = mapViewFactory.mapView
    }
}
