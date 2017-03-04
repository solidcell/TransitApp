import UIKitFringes
import CoreLocation

class CLLocationManagerPresenter {
    
    fileprivate weak var viewController: CLLocationManagerViewControlling!

    func set(viewController: CLLocationManagerViewControlling) {
        self.viewController = viewController
    }

    func set(title text: String) {
        viewController.set(title: text)
    }

    func set(authorizationStatus: CLAuthorizationStatus) {
        viewController.set(authorizationStatus: String(describing: authorizationStatus))
    }
}
