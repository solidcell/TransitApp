import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let mapCoordinator = MapCoordinator()
    
    private let mapViewFactory: MapViewFactory
    private let urlSession: URLSessionProtocol
    private let timerFactory: TimerFactoryProtocol
    private let locationManagerFactory: LocationManagingFactoryProtocol

    init(mapViewFactory: MapViewFactory,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        self.mapViewFactory = mapViewFactory
        self.urlSession = urlSession
        self.timerFactory = timerFactory
        self.locationManagerFactory = locationManagerFactory
    }

    func didFinishLaunching(withWindow window: UIWindow) {
        let jsonFetcher = JSONFetcher(urlSession: urlSession)
        mapCoordinator.start(window: window,
                             viewFactory: mapViewFactory,
                             jsonFetcher: jsonFetcher,
                             timerFactory: timerFactory,
                             locationManagerFactory: locationManagerFactory)
    }
}
