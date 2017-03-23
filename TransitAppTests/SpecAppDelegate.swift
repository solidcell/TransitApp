import Foundation
import SpecUIKitFringes
@testable import TransitApp

class SpecAppDelegate: SpecApplicationDelegateProtocol {

    private(set) var window: UIWindow!
    private weak var dialogManager: SpecDialogManager!
    private weak var dateProvider: SpecDateProvider!
    private weak var urlSession: SpecURLSession!
    private weak var locationManagerFactory: SpecLocationManagerFactory!
    
    init(dialogManager: SpecDialogManager,
         dateProvider: SpecDateProvider,
         urlSession: SpecURLSession,
         locationManagerFactory: SpecLocationManagerFactory) {
        self.dialogManager = dialogManager
        self.dateProvider = dateProvider
        self.urlSession = urlSession
        self.locationManagerFactory = locationManagerFactory
    }

    func applicationDidLaunch() {
        window = UIWindow()
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
        let mapViewControllerFactory = SpecMapViewFactory()
        let dispatchHandler = SpecDispatchHandler(dateProvider: dateProvider)
        let appCoordinator = AppCoordinator(mapViewControllerFactory: mapViewControllerFactory,
                                            urlSession: urlSession,
                                            timerFactory: timerFactory,
                                            locationManagerFactory: locationManagerFactory,
                                            dispatchHandler: dispatchHandler)
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
