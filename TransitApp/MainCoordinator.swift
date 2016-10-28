import UIKit

class MainCoordinator {

    private let mapViewCoordinator = MapViewControllerCoordinator()

    func start(window: UIWindow) {
        mapViewCoordinator.start(window: window)
    }
    
}
