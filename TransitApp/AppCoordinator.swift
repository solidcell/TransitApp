import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let mapCoordinatorFactory: MapCoordinatorFactory

    init(mapViewFactory: MapViewFactory,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        let jsonFetcher = JSONFetcher(urlSession: urlSession)
        self.mapCoordinatorFactory = MapCoordinatorFactory(viewFactory: mapViewFactory,
                                                           jsonFetcher: jsonFetcher,
                                                           timerFactory: timerFactory,
                                                           locationManagerFactory: locationManagerFactory)
    }

    func didFinishLaunching(withWindow window: UIWindow) {
        let mapCoordinator = mapCoordinatorFactory.create()
        mapCoordinator.start(window: window)
    }
}
