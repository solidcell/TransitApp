import UIKit

class DateViewControllerFactory: DateViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: DateInteractor) -> DateViewControlling {
        return DateViewController.create(withInteractor: interactor)
    }
}

extension DateViewController {

    static let storyboardName = "DateViewController"

    class func create(withInteractor interactor: DateInteractor) -> DateViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! DateViewController
        vc.interactor = interactor
        return vc
    }
}

protocol DateViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: DateInteractor) -> DateViewControlling
}
