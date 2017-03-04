import UIKit

class TimerViewControllerFactory: TimerViewControllerFactoryProtocol {

    func create(withInteractor interactor: TimerInteractor) -> TimerViewControlling {
        return TimerViewController.create(interactor: interactor)
    }
}

extension TimerViewController {

    static let storyboardName = "TimerViewController"

    class func create(interactor: TimerInteractor) -> TimerViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! TimerViewController
        vc.interactor = interactor
        return vc
    }
}

protocol TimerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: TimerInteractor) -> TimerViewControlling
}
