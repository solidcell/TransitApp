import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let mapCoordinatorFactory: MapCoordinatorFactory

    init(mapViewFactory: MapViewFactory,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        let jsonFetcherFactory = JSONFetcherFactory(urlSession: urlSession)
        self.mapCoordinatorFactory = MapCoordinatorFactory(viewFactory: mapViewFactory,
                                                           jsonFetcherFactory: jsonFetcherFactory,
                                                           timerFactory: timerFactory,
                                                           locationManagerFactory: locationManagerFactory)
    }

    func didFinishLaunching(withWindow window: Windowing) {
        let mapCoordinator = mapCoordinatorFactory.create()
        mapCoordinator.start(window: window)
    }
}
