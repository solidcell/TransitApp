import UIKit

class OnboardingViewController: UIViewController {

    var interactor: OnboardingInteractor!
    
    @IBAction func didTapSkip() {
        interactor.didTapSkip()
    }
}

protocol OnboardingViewControllerFactoryProtocol {
    
    func create() -> OnboardingViewController
}

class OnboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol {
    
    private let storyboardName = "OnboardingViewController"
    
    func create() -> OnboardingViewController {
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! OnboardingViewController
    }
}
