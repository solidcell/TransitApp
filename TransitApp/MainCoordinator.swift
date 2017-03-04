import UIKit
import RealmSwift
import UIKitFringes

class MainCoordinator {

    private let mapCoordinator = MapCoordinator()

    func start(window: UIWindow,
               mapViewFactory: MapViewFactory,
               realm: Realm,
               scooterRealmNotifier: ScooterRealmNotifier,
               jsonFetcher: JSONFetching,
               fetchTimer: FetchTiming,
               locationManager: LocationManaging) {
        let seedDataParser = SeedDataParser(realm: realm)
        seedDataParser.seedIfNeeded()
        mapCoordinator.start(window: window,
                             viewFactory: mapViewFactory,
                             realm: realm,
                             scooterRealmNotifier: scooterRealmNotifier,
                             jsonFetcher: jsonFetcher,
                             fetchTimer: fetchTimer,
                             locationManager: locationManager)
    }
    
}
