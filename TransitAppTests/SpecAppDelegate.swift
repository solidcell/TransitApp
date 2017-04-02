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
    private weak var userDefaults: SpecUserDefaults!
    
    init(dialogManager: SpecDialogManager,
         dateProvider: SpecDateProvider,
         urlSession: SpecURLSession,
         locationManagerFactory: SpecLocationManagerFactory,
         sharedApplication: SpecSharedApplication,
         userDefaults: SpecUserDefaults) {
        self.dialogManager = dialogManager
        self.dateProvider = dateProvider
        self.urlSession = urlSession
        self.locationManagerFactory = locationManagerFactory
        self.sharedApplication = sharedApplication
        self.userDefaults = userDefaults
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
                                            sharedApplication: sharedApplication,
                                            userDefaults: userDefaults)
        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
