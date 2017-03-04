import UIKitFringes

class ExamplesNavigationModuleFactory {

    let viewControllerFactory: ExamplesNavigationControllerFactoryProtocol

    init(viewControllerFactory: ExamplesNavigationControllerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
    }

    func create(rootViewController: ViewControlling) -> ViewControlling {
        let presenter = ExamplesNavigationPresenter()
        let viewController = viewControllerFactory.create()
        presenter.set(viewController: viewController, rootViewController: rootViewController)
        return viewController
    }
}
