import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let mapCoordinator = MapCoordinator()
    
    func start(window: UIWindow,
               mapViewFactory: MapViewFactory,
               urlSession: URLSessionProtocol,
               timerFactory: TimerFactoryProtocol,
               locationManager: LocationManaging) {
        let jsonFetcher = JSONFetcher(urlSession: urlSession)
        mapCoordinator.start(window: window,
                             viewFactory: mapViewFactory,
                             jsonFetcher: jsonFetcher,
                             timerFactory: timerFactory,
                             locationManager: locationManager)
    }

}
