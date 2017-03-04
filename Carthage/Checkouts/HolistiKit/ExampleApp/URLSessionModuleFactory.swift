import UIKitFringes

class URLSessionModuleFactory {

    private let viewControllerFactory: URLSessionViewControllerFactoryProtocol
    private let errorLogger: ErrorLogging
    private let networkActivityManager: NetworkActivityManager
    private let urlSession: URLSessionProtocol

    init(viewControllerFactory: URLSessionViewControllerFactoryProtocol,
         errorLogger: ErrorLogging,
         networkActivityManager: NetworkActivityManager,
         urlSession: URLSessionProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.errorLogger = errorLogger
        self.networkActivityManager = networkActivityManager
        self.urlSession = urlSession
    }

    func create() -> ViewControlling {
        let presenter = URLSessionPresenter(errorLogger: errorLogger)
        let interactor = URLSessionInteractor(presenter: presenter,
                                              errorLogger: errorLogger,
                                              networkActivityManager: networkActivityManager,
                                              urlSession: urlSession)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
