import UIKit
import RealmSwift
import FakeLocationManager

class MainCoordinator {

    private let mapCoordinator = MapCoordinator()

    func start(window: UIWindow,
               realm: Realm,
               scooterRealmNotifier: ScooterRealmNotifier,
               jsonFetcher: JSONFetching,
               fetchTimer: FetchTiming,
               locationManager: LocationManaging) {
        let seedDataParser = SeedDataParser(realm: realm)
        seedDataParser.seedIfNeeded()
        mapCoordinator.start(window: window,
                             realm: realm,
                             scooterRealmNotifier: scooterRealmNotifier,
                             jsonFetcher: jsonFetcher,
                             fetchTimer: fetchTimer,
                             locationManager: locationManager)
    }
    
}
