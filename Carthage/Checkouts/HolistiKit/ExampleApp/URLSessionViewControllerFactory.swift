import UIKit

class URLSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol {

    func create(withInteractor interactor: URLSessionInteractor) -> URLSessionViewControlling {
        return URLSessionViewController.create(withInteractor: interactor)
    }
}

extension URLSessionViewController {

    static let storyboardName = "URLSessionViewController"

    class func create(withInteractor interactor: URLSessionInteractor) -> URLSessionViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! URLSessionViewController
        vc.interactor = interactor
        return vc
    }
}

protocol URLSessionViewControllerFactoryProtocol {

    func create(withInteractor interactor: URLSessionInteractor) -> URLSessionViewControlling
}
