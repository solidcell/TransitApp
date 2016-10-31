import UIKit
import RealmSwift

class MapSelectorCoordinator {

    private let realm: Realm
    private let mapSourceManager: MapSourceManager
    private weak var viewController: MapSelectorViewController?

    init(realm: Realm) {
        self.realm = realm
        self.mapSourceManager = MapSourceManager(realm: realm)
        mapSourceManager.delegate = self
    }

    func start(window: UIWindow, realm: Realm) {
        let segmentedControlSource = SegmentedControlSource(mapSourceManager: self.mapSourceManager)
        let viewController = MapSelectorViewController.createFromStoryboard(delegate: self,
                                                                            segmentedControlSource: segmentedControlSource)
        window.rootViewController = viewController
        self.viewController = viewController
    }

    fileprivate func addMapViewController() {
        guard let viewController = viewController else { return }
        let mapCoordinator = MapCoordinator()
        let mapViewController = mapCoordinator.start(realm: realm)
        viewController.add(mapViewController: mapViewController)
    }

}

extension MapSelectorCoordinator: MapSelectorViewControllerDelegate {

    func viewDidLoad() {
        addMapViewController()
    }
    
}

extension MapSelectorCoordinator: MapSourceManagerDelegate {

    func didUpdate(source: MapSourceManager.Source) {
        addMapViewController()
    }
    
}

protocol MapSelectorViewControllerDelegate: class {
    func viewDidLoad()
}
