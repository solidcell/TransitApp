import UIKit
import RealmSwift

class MapSelectorCoordinator {

    private let realm: Realm
    private let mapSourceManager: MapSourceManager
    private let mapViewControllerCache = MapViewControllerCache()
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

    fileprivate func setMapViewController() {
        guard let viewController = viewController else { return }
        let source = mapSourceManager.source
        let mapVC = mapViewController(for: source)
        viewController.add(mapViewController: mapVC)
    }

    fileprivate func mapViewController(for source: MapSourceManager.Source) -> UIViewController {
        // return cached map view controller if it exists
        let cachedViewController = mapViewControllerCache.get(for: source)
        if let cachedViewController = cachedViewController { return cachedViewController }

        // otherwise return a new map view controller and cache it
        let mapCoordinator = MapCoordinator()
        let mapViewController = mapCoordinator.start(realm: realm)
        mapViewControllerCache.add(mapViewController, for: source)
        return mapViewController
    }

}

extension MapSelectorCoordinator: MapSelectorViewControllerDelegate {

    func viewDidLoad() {
        setMapViewController()
    }
    
}

extension MapSelectorCoordinator: MapSourceManagerDelegate {

    func didUpdate(source: MapSourceManager.Source) {
        setMapViewController()
    }
    
}

protocol MapSelectorViewControllerDelegate: class {
    func viewDidLoad()
}
