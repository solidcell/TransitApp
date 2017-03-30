import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let rootRouterFactory: RootRouterFactory

    init(mapViewControllerFactory: MapViewControllerFactoryProtocol,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol,
         dispatchHandler: DispatchHandling,
         sharedApplication: ApplicationProtocol) {
        let jsonFetcherFactory = JSONFetcherFactory(urlSession: urlSession)
        let mapModuleFactory = MapModuleFactory(viewFactory: mapViewControllerFactory,
                                                jsonFetcherFactory: jsonFetcherFactory,
                                                timerFactory: timerFactory,
                                                locationManagerFactory: locationManagerFactory,
                                                dispatchHandler: dispatchHandler,
                                                sharedApplication: sharedApplication)
        let mapRouterFactory = MapRouterFactory(mapModuleFactory: mapModuleFactory)
        self.rootRouterFactory = RootRouterFactory(mapRouterFactory: mapRouterFactory)
    }

    func didFinishLaunching(withWindow window: UIWindow) {
        let rootRouter = rootRouterFactory.create()
        rootRouter.start(window: window)
    }
}
