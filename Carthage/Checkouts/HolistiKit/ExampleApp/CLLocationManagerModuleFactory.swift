import UIKitFringes

class CLLocationManagerModuleFactory {

    private let viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol
    private let locationManagerFactory: LocationManagingFactoryProtocol
    private let errorLogger: ErrorLogging

    init(viewControllerFactory: CLLocationManagerViewControllerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol,
         errorLogger: ErrorLogging) {
        self.viewControllerFactory = viewControllerFactory
        self.locationManagerFactory = locationManagerFactory
        self.errorLogger = errorLogger
    }

    func create() -> ViewControlling {
        let presenter = CLLocationManagerPresenter()
        let locationManager = locationManagerFactory.create()
        let interactor = CLLocationManagerInteractor(presenter: presenter,
                                                     locationManager: locationManager,
                                                     errorLogger: errorLogger)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
