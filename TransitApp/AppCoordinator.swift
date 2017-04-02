import UIKit
import UIKitFringes
import CoreLocation

class AppCoordinator {
    
    private let rootRouterFactory: RootRouterFactory

    init(mapViewControllerFactory: MapViewControllerFactoryProtocol,
         onboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol,
         urlSession: URLSessionProtocol,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol,
         dispatchHandler: DispatchHandling,
         sharedApplication: ApplicationProtocol,
         userDefaults: UserDefaulting) {
        let jsonFetcherFactory = JSONFetcherFactory(urlSession: urlSession)
        let mapModuleFactory = MapModuleFactory(viewFactory: mapViewControllerFactory,
                                                jsonFetcherFactory: jsonFetcherFactory,
                                                timerFactory: timerFactory,
                                                locationManagerFactory: locationManagerFactory,
                                                dispatchHandler: dispatchHandler,
                                                sharedApplication: sharedApplication)
        let mapRouterFactory = MapRouterFactory(mapModuleFactory: mapModuleFactory)
        let onboardingModuleFactory = OnboardingModuleFactory(viewControllerFactory: onboardingViewControllerFactory)
        let onboardingRouterFactory = OnboardingRouterFactory(onboardingModuleFactory: onboardingModuleFactory)
        self.rootRouterFactory = RootRouterFactory(mapRouterFactory: mapRouterFactory,
                                                   onboardingRouterFactory: onboardingRouterFactory,
                                                   userDefaults: userDefaults)
    }

    func didFinishLaunching(withWindow window: UIWindow) {
        let rootRouter = rootRouterFactory.create()
        window.rootViewController = rootRouter.viewController
    }
}
