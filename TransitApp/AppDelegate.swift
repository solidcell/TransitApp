import UIKit
import CoreLocation
import UIKitFringes

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let coordinator = AppCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let mapViewFactory = MapViewControllerFactory()
        let urlSession = URLSession(configuration: .default)
        let timerFactory = TimerFactory()
        let locationManager = CLLocationManager()
        coordinator.start(window: window,
                          mapViewFactory: mapViewFactory,
                          urlSession: urlSession,
                          timerFactory: timerFactory,
                          locationManager: locationManager)
        
        window.makeKeyAndVisible()
        return true
    }

}
