import UIKit
import RealmSwift

class MainCoordinator {

    private let realm = try! Realm()
    private let seedDataParser: SeedDataParser
    private let mapCoordinator = MapCoordinator()

    init() {
        self.seedDataParser = SeedDataParser(realm: realm)
    }

    func start(window: UIWindow) {
        seedDataParser.seedIfNeeded()
        let scooterRealmNotifier = ScooterRealmNotifier(realm: realm)
        let jsonFetcher = JSONFetcher()
        let fetchTimer = FetchTimer()
        mapCoordinator.start(window: window,
                             realm: realm,
                             scooterRealmNotifier: scooterRealmNotifier,
                             jsonFetcher: jsonFetcher,
                             fetchTimer: fetchTimer)
    }
    
}
