import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let mapRouterFactory: MapRouterFactory

    init(mapViewControllerFactory: MapViewControllerFactoryProtocol,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol,
         dispatchHandler: DispatchHandling) {
        let jsonFetcherFactory = JSONFetcherFactory(urlSession: urlSession)
        let mapModuleFactory = MapModuleFactory(viewFactory: mapViewControllerFactory,
                                                jsonFetcherFactory: jsonFetcherFactory,
                                                timerFactory: timerFactory,
                                                locationManagerFactory: locationManagerFactory,
                                                dispatchHandler: dispatchHandler)
        self.mapRouterFactory = MapRouterFactory(mapModuleFactory: mapModuleFactory)
    }

    func didFinishLaunching(withWindow window: UIWindow) {
        let mapRouter = mapRouterFactory.create()
        mapRouter.start(window: window)
    }
}
