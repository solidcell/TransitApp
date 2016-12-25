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

        beforeEach {
            scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
            jsonFetcher = SpecJSONFetcher()
            fetchTimer = SpecFetchTimer()
            locationManager = FakeLocationManager()
            subject = MainCoordinator()
            subject.start(window: UIWindow(),
                          realm: self.realm,
                          scooterRealmNotifier: scooterRealmNotifier,
                          jsonFetcher: jsonFetcher,
                          fetchTimer: fetchTimer,
                          locationManager: locationManager)
        }
    }
    
}
