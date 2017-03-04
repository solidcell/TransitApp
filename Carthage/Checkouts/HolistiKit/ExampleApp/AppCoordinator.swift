import UIKitFringes

class AppCoordinator {

    private let router: RootRouter

    init(examplesNavigationControllerFactory: ExamplesNavigationControllerFactoryProtocol,
         examplesViewControllerFactory: ExamplesViewControllerFactoryProtocol,
         timerViewControllerFactory: TimerViewControllerFactoryProtocol,
         urlSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol,
         dateViewControllerFactory: DateViewControllerFactoryProtocol,
         uiViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol,
         clLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         errorLogger: ErrorLogging,
         timerFactory: TimerFactoryProtocol,
         sharedApplication: ApplicationProtocol,
         urlSession: URLSessionProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        let networkActivityManager = NetworkActivityManager(sharedApplication: sharedApplication)
        let examplesNavigationModuleFactory = ExamplesNavigationModuleFactory(viewControllerFactory: examplesNavigationControllerFactory)
        let examplesModuleFactory = ExamplesModuleFactory(viewControllerFactory: examplesViewControllerFactory,
                                                          errorLogger: errorLogger)
        let timerModuleFactory = TimerModuleFactory(viewControllerFactory: timerViewControllerFactory,
                                                    dateProvider: dateProvider,
                                                    timeZoneProvider: timeZoneProvider,
                                                    timerFactory: timerFactory)
        let urlSessionModuleFactory = URLSessionModuleFactory(viewControllerFactory: urlSessionViewControllerFactory,
                                                              errorLogger: errorLogger,
                                                              networkActivityManager: networkActivityManager,
                                                              urlSession: urlSession)
        let dateModuleFactory = DateModuleFactory(viewControllerFactory: dateViewControllerFactory,
                                                  dateProvider: dateProvider,
                                                  timeZoneProvider: timeZoneProvider)
        let uiViewControllerModuleFactory = UIViewControllerModuleFactory(viewControllerFactory: uiViewControllerViewControllerFactory,
                                                                          errorLogger: errorLogger)
        let clLocationManagerModuleFactory = CLLocationManagerModuleFactory(viewControllerFactory: clLocationManagerViewControllerFactory,
                                                                            locationManagerFactory: locationManagerFactory,
                                                                            errorLogger: errorLogger)
        let examplesRouterFactory = ExamplesRouterFactory(examplesNavigationModuleFactory: examplesNavigationModuleFactory,
                                                          examplesModuleFactory: examplesModuleFactory,
                                                          timerModuleFactory: timerModuleFactory,
                                                          urlSessionModuleFactory: urlSessionModuleFactory,
                                                          dateModuleFactory: dateModuleFactory,
                                                          uiViewControllerModuleFactory: uiViewControllerModuleFactory,
                                                          clLocationManagerModuleFactory: clLocationManagerModuleFactory)
        self.router = RootRouter(examplesRouterFactory: examplesRouterFactory)
    }

    func didFinishLaunching(withWindow window: Windowing) {
        router.present(onWindow: window)
    }
}
