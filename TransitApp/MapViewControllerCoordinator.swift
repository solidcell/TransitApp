import UIKit

class MapViewControllerCoordinator {

    func start(window: UIWindow) {
        let viewController = MapViewController.createFromStoryboard()
        window.rootViewController = viewController
    }
    
}
