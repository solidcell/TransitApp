import UIKit
import RealmSwift
import UIKitFringes

class MainCoordinator {

    private let mapCoordinator = MapCoordinator()

    func start(window: UIWindow,
               mapViewFactory: MapViewFactory,
               realm: Realm,
               jsonFetcher: JSONFetching,
               fetchTimer: FetchTiming,
               locationManager: LocationManaging) {
        let seedDataParser = SeedDataParser(realm: realm)
        seedDataParser.seedIfNeeded()
        mapCoordinator.start(window: window,
                             viewFactory: mapViewFactory,
                             realm: realm,
                             jsonFetcher: jsonFetcher,
                             fetchTimer: fetchTimer,
                             locationManager: locationManager)
    }
    
}
