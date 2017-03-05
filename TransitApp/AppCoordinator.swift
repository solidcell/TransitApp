import UIKit
import UIKitFringes

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
        let urlSession = URLSession(configuration: .default)
        let timerFactory = TimerFactory()
        let locationManager = CLLocationManager()
        coordinator.start(window: window,
                          mapViewFactory: mapViewFactory,
                          urlSession: urlSession,
                          timerFactory: timerFactory,
                          locationManager: locationManager)
    }

}
