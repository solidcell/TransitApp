import UIKitFringes

class UIViewControllerModuleFactory {

    private let viewControllerFactory: UIViewControllerViewControllerFactoryProtocol
    private let errorLogger: ErrorLogging
    
    init(viewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
    }

    func create(withRouter router: ExamplesRouter) -> ViewControlling {
        let presenter = UIViewControllerPresenter(router: router)
        let interactor = UIViewControllerInteractor(presenter: presenter,
                                                    errorLogger: errorLogger)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
