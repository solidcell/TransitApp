import Quick
import Nimble
import RealmSwift
import MapKit
import FakeLocationManager
@testable import TransitApp

class BlahSpec: TransitAppSpec {
    
    override func spec() {
        super.spec()

        var subject: MainCoordinator!
        var scooterRealmNotifier: SpecScooterRealmNotifier!
        var jsonFetcher: SpecJSONFetcher!
        var fetchTimer: SpecFetchTimer!
        var locationManager: FakeLocationManager!
        var mapView: SpecMapView!

        beforeEach {
            scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
            jsonFetcher = SpecJSONFetcher()
            fetchTimer = SpecFetchTimer()
            locationManager = FakeLocationManager()
            let mapViewFactory = SpecMapViewFactory()
            subject = MainCoordinator()
            subject.start(window: UIWindow(),
                          mapViewFactory: mapViewFactory,
                          realm: self.realm,
                          scooterRealmNotifier: scooterRealmNotifier,
                          jsonFetcher: jsonFetcher,
                          fetchTimer: fetchTimer,
                          locationManager: locationManager)
            mapView = mapViewFactory.mapView
        }

        describe("tapping on the Current Location Arrow") {

            beforeEach {
                mapView.tapCurrentLocationButton()
            }

            it("will present an authorization dialog") {
                locationManager.tapAllowInDialog()
            }

        }
    }
    
}
