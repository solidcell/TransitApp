import UIKit
import UIKitFringes

class RootRouter {

    private let mapRouterFactory: MapRouterFactory
    private let onboardingRouterFactory: OnboardingRouterFactory
    private let onboardingExperience: OnboardingExperience

    init(mapRouterFactory: MapRouterFactory,
         onboardingRouterFactory: OnboardingRouterFactory,
         onboardingExperience: OnboardingExperience) {
        self.mapRouterFactory = mapRouterFactory
        self.onboardingRouterFactory = onboardingRouterFactory
        self.onboardingExperience = onboardingExperience
    }

    var viewController: UIViewController {
        if onboardingExperience.experience {
            let onboardingRouter = onboardingRouterFactory.create(rootRouter: self)
            return onboardingRouter.viewController
        } else {
            let mapRouter = mapRouterFactory.create()
            return mapRouter.viewController
        }
    }

    func presentMap(on presenter: UIViewController) {
        let mapRouter = mapRouterFactory.create()
        let mapViewController = mapRouter.viewController
        presenter.present(mapViewController, animated: true)
    }
}

class RootRouterFactory {
    
    private let mapRouterFactory: MapRouterFactory
    private let onboardingRouterFactory: OnboardingRouterFactory
    private let userDefaults: UserDefaulting
    
    init(mapRouterFactory: MapRouterFactory,
         onboardingRouterFactory: OnboardingRouterFactory,
         userDefaults: UserDefaulting) {
        self.mapRouterFactory = mapRouterFactory
        self.onboardingRouterFactory = onboardingRouterFactory
        self.userDefaults = userDefaults
    }

    func create() -> RootRouter {
        let onboardingExperience = OnboardingExperience(userDefaults: userDefaults)
        return RootRouter(mapRouterFactory: mapRouterFactory,
                          onboardingRouterFactory: onboardingRouterFactory,
                          onboardingExperience: onboardingExperience)
    }
}
