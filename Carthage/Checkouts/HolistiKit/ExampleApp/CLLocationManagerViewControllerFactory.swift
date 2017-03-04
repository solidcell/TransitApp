import UIKit

class CLLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol {

    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewControlling {
        return CLLocationManagerViewController.create(interactor: interactor)
    }
}

extension CLLocationManagerViewController {

    static let storyboardName = "CLLocationManagerViewController"

    class func create(interactor: CLLocationManagerInteractor) -> CLLocationManagerViewControlling {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! CLLocationManagerViewController
        vc.interactor = interactor
        return vc
    }
}

protocol CLLocationManagerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewControlling
}
