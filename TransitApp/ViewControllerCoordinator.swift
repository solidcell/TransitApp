import UIKit

class ViewControllerCoordinator {

    func start(window: UIWindow) {
        let viewController = ViewController.createFromStoryboard()
        window.rootViewController = viewController
    }
    
}
