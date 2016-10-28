import UIKit

class MapCoordinator {

    func start(window: UIWindow) {
        let viewController = MapViewController.createFromStoryboard()
        window.rootViewController = viewController
    }
    
}
