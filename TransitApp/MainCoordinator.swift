import UIKit
import UIKitFringes
import RealmSwift
import UIKitFringes

class MainCoordinator {

    private let mapCoordinator = MapCoordinator()

    func start(window: UIWindow,
               mapViewFactory: MapViewFactory,
               realm: Realm,
               urlSession: URLSessionProtocol,
               timerFactory: TimerFactoryProtocol,
               locationManager: LocationManaging) {
        let jsonFetcher = JSONFetcher(urlSession: urlSession)
        mapCoordinator.start(window: window,
                             viewFactory: mapViewFactory,
                             realm: realm,
                             jsonFetcher: jsonFetcher,
                             timerFactory: timerFactory,
                             locationManager: locationManager)
    }
    
}
