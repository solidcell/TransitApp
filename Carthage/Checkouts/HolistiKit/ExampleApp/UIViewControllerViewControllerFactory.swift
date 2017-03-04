import UIKit

class UIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {

    func create(withInteractor interactor: UIViewControllerInteractor) -> UIViewControllerViewControlling {
        return UIViewControllerViewController.create(withInteractor: interactor)
    }
}

extension UIViewControllerViewController {

    static let storyboardName = "UIViewControllerViewController"

    class func create(withInteractor interactor: UIViewControllerInteractor) -> UIViewControllerViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! UIViewControllerViewController
        vc.interactor = interactor
        return vc
    }
}

protocol UIViewControllerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: UIViewControllerInteractor) -> UIViewControllerViewControlling
}
