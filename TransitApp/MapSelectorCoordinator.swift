import UIKit
import RealmSwift

class MapSelectorCoordinator {

    fileprivate let realm: Realm
    fileprivate weak var viewController: MapSelectorViewController?

    init(realm: Realm) {
        self.realm = realm
    }

    func start(window: UIWindow, realm: Realm) {
        let mapSourceManager = MapSourceManager(realm: realm)
        let segmentedControlSource = SegmentedControlSource(mapSourceManager: mapSourceManager)
        let viewController = MapSelectorViewController.createFromStoryboard(delegate: self,
                                                                            segmentedControlSource: segmentedControlSource)
        window.rootViewController = viewController
        self.viewController = viewController
    }

}

extension MapSelectorCoordinator: MapSelectorViewControllerDelegate {

    func viewDidLoad() {
        addMapViewController()
    }

    private func addMapViewController() {
        guard let viewController = viewController else { return }
        let mapCoordinator = MapCoordinator()
        let mapViewController = mapCoordinator.start(realm: realm)
        viewController.add(mapViewController: mapViewController)
    }
    
}

protocol MapSelectorViewControllerDelegate: class {
    func viewDidLoad()
}
