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
        mapCoordinator.start(window: window, realm: realm)
    }
    
}
