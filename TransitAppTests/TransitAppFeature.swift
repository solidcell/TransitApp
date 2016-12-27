import Quick
import FakeLocationManager
@testable import TransitApp

class TransitAppFeature: TransitAppSpec {

    var scooterUpdater: SpecScooterUpdater!
    // Let the object graph hold onto this, so as not to
    // mask possible retain issues
    weak var locationManager: FakeLocationManager!
    // Hold onto these, as the AppDelegate and UIKit would
    var subject: MainCoordinator!
    var mapView: SpecMapViewInterating!

    override func spec() {
        super.spec()

        beforeEach {
            let scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
            let jsonFetcher = SpecJSONFetcher()
            let fetchTimer = SpecFetchTimer()
            self.scooterUpdater = SpecScooterUpdater(scooterRealmNotifier: scooterRealmNotifier,
                                                jsonFetcher: jsonFetcher,
                                                fetchTimer: fetchTimer)
            let _locationManager = FakeLocationManager()
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
    
}
