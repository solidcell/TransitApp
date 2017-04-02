import Foundation
import SpecUIKitFringes
@testable import TransitApp

class SpecAppDelegate: SpecApplicationDelegateProtocol {

    private(set) var window: UIWindow!
    private weak var dialogManager: SpecDialogManager!
    private weak var dateProvider: SpecDateProvider!
    private weak var urlSession: SpecURLSession!
    private weak var locationManagerFactory: SpecLocationManagerFactory!
    private weak var sharedApplication: SpecSharedApplication!
    
    init(dialogManager: SpecDialogManager,
         dateProvider: SpecDateProvider,
         urlSession: SpecURLSession,
         locationManagerFactory: SpecLocationManagerFactory,
         sharedApplication: SpecSharedApplication) {
        self.dialogManager = dialogManager
        self.dateProvider = dateProvider
        self.urlSession = urlSession
        self.locationManagerFactory = locationManagerFactory
        self.sharedApplication = sharedApplication
    }

    func applicationDidLaunch() {
        window = UIWindow()
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
        let mapViewControllerFactory = SpecMapViewFactory()
        let onboardingViewControllerFactory = SpecOnboardingViewControllerFactory()
        let dispatchHandler = SpecDispatchHandler(dateProvider: dateProvider)
        let appCoordinator = AppCoordinator(mapViewControllerFactory: mapViewControllerFactory,
                                            onboardingViewControllerFactory: onboardingViewControllerFactory,
                                            urlSession: urlSession,
                                            timerFactory: timerFactory,
                                            locationManagerFactory: locationManagerFactory,
                                            dispatchHandler: dispatchHandler,
                                            sharedApplication: sharedApplication)
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
