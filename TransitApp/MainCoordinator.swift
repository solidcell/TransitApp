import UIKit
import RealmSwift

class MainCoordinator {

    private let mapCoordinator = MapCoordinator()
    private let realm = try! Realm()
    private let seedDataParser: SeedDataParser

    init() {
        seedDataParser = SeedDataParser(realm: realm)
    }

    func start(window: UIWindow) {
        seedDataParser.seedIfNeeded()
        mapCoordinator.start(window: window)
    }
    
}
