import SpecUIKitFringes
@testable import ExampleApp

class SpecAppDelegate: SpecApplicationDelegateProtocol {
    
    private(set) var window: SpecWindow!
    
    private weak var sharedApplication: SpecSharedApplication!
    private weak var dateProvider: SpecDateProvider!
    private weak var timeZoneProvider: SpecTimeZoneProvider!
    private weak var urlSession: SpecURLSession!
    private weak var locationManagerFactory: SpecLocationManagerFactory!

    init(sharedApplication: SpecSharedApplication,
         dateProvider: SpecDateProvider,
         timeZoneProvider: SpecTimeZoneProvider,
         urlSession: SpecURLSession,
         locationManagerFactory: SpecLocationManagerFactory) {
        self.sharedApplication = sharedApplication
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
        self.urlSession = urlSession
        self.locationManagerFactory = locationManagerFactory
    }

    func applicationDidLaunch() {

        window = SpecWindow()

        let examplesNavigationControllerFactory = SpecExamplesNavigationControllerFactory()
        let examplesViewControllerFactory = SpecExamplesViewControllerFactory()
        let timerViewControllerFactory = SpecTimerViewControllerFactory()
        let urlSessionViewControllerFactory = SpecURLSessionViewControllerFactory()
        let dateViewControllerFactory = SpecDateViewControllerFactory()
        let uiViewControllerViewControllerFactory = SpecUIViewControllerViewControllerFactory()
        let clLocationManagerViewControllerFactory = SpecCLLocationManagerViewControllerFactory()
        let errorLogger = SpecErrorLogger()
        let timerFactory = SpecTimerFactory(dateProvider: dateProvider)
        let appCoordinator = AppCoordinator(examplesNavigationControllerFactory: examplesNavigationControllerFactory,
                                            examplesViewControllerFactory: examplesViewControllerFactory,
                                            timerViewControllerFactory: timerViewControllerFactory,
                                            urlSessionViewControllerFactory: urlSessionViewControllerFactory,
                                            dateViewControllerFactory: dateViewControllerFactory,
                                            uiViewControllerViewControllerFactory: uiViewControllerViewControllerFactory,
                                            clLocationManagerViewControllerFactory: clLocationManagerViewControllerFactory,
                                            dateProvider: dateProvider,
                                            timeZoneProvider: timeZoneProvider,
                                            errorLogger: errorLogger,
                                            timerFactory: timerFactory,
                                            sharedApplication: sharedApplication,
                                            urlSession: urlSession,
                                            locationManagerFactory: locationManagerFactory)

        appCoordinator.didFinishLaunching(withWindow: window)
    }
}
