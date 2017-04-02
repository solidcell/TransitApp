import UIKit

class OnboardingModuleFactory {

    private let viewControllerFactory: OnboardingViewControllerFactoryProtocol
    
    init(viewControllerFactory: OnboardingViewControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(router: OnboardingRouter) -> OnboardingViewController {
        let presenter = OnboardingPresenter(router: router)
        let interactor = OnboardingInteractor(presenter: presenter)
        let viewController = viewControllerFactory.create()
        viewController.interactor = interactor
        presenter.viewController = viewController
        return viewController
    }
}
