import UIKit
import RealmSwift

class MainCoordinator {

    private let realm = try! Realm()
    private let seedDataParser: SeedDataParser
    private let mapSelectorCoordinator: MapSelectorCoordinator

    init() {
        self.seedDataParser = SeedDataParser(realm: realm)
        self.mapSelectorCoordinator = MapSelectorCoordinator(realm: realm)
    }

    func start(window: UIWindow) {
        seedDataParser.seedIfNeeded()
        mapSelectorCoordinator.start(window: window, realm: realm)
    }
    
}
