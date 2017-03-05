import UIKit
import UIKitFringes
import RealmSwift
import CoreLocation

/*
 NOTE: This class isn't tested.
 This is where dependencies are created and things are
 kicked off. When integration testing the app holistically,
 this is the highest up the object graph that one will go.
 */

class AppCoordinator {
    
    private let coordinator = MainCoordinator()
    
    func start(window: UIWindow) {
        let mapViewFactory = MapViewControllerFactory()
        let realm = try! Realm()
        let urlSession = URLSession(configuration: .default)
        let timerFactory = TimerFactory()
        let locationManager = CLLocationManager()
        coordinator.start(window: window,
                          mapViewFactory: mapViewFactory,
                          realm: realm,
                          urlSession: urlSession,
                          timerFactory: timerFactory,
                          locationManager: locationManager)
    }

}
