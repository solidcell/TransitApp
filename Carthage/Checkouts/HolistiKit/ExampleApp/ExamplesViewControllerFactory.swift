import UIKit

class ExamplesViewControllerFactory: ExamplesViewControllerFactoryProtocol {

    func create(withInteractor interactor: ExamplesInteractor) -> ExamplesViewControlling {
        return ExamplesViewController.create(interactor: interactor)
    }
}

extension ExamplesViewController {

    static let storyboardName = "ExamplesViewController"

    class func create(interactor: ExamplesInteractor) -> ExamplesViewControlling {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! ExamplesViewController
        vc.interactor = interactor
        return vc
    }
}

protocol ExamplesViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: ExamplesInteractor) -> ExamplesViewControlling
}
