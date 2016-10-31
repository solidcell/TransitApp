import UIKit
import RealmSwift

class MainCoordinator {

    private let mapSelectorCoordinator = MapSelectorCoordinator()
    private let realm = try! Realm()
    private let seedDataParser: SeedDataParser

    init() {
        seedDataParser = SeedDataParser(realm: realm)
    }

    func start(window: UIWindow) {
        seedDataParser.seedIfNeeded()
        mapSelectorCoordinator.start(window: window, realm: realm)
    }
    
}
