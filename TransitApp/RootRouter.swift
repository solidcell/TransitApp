import UIKit

class RootRouter {

    private let mapRouterFactory: MapRouterFactory
    private let onboardingRouterFactory: OnboardingRouterFactory

    init(mapRouterFactory: MapRouterFactory,
         onboardingRouterFactory: OnboardingRouterFactory) {
        self.mapRouterFactory = mapRouterFactory
        self.onboardingRouterFactory = onboardingRouterFactory
    }

    var viewController: UIViewController {
        let onboardingRouter = onboardingRouterFactory.create(rootRouter: self)
        return onboardingRouter.viewController
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
    
    init(mapRouterFactory: MapRouterFactory,
         onboardingRouterFactory: OnboardingRouterFactory) {
        self.mapRouterFactory = mapRouterFactory
        self.onboardingRouterFactory = onboardingRouterFactory
    }

    func create() -> RootRouter {
        return RootRouter(mapRouterFactory: mapRouterFactory,
                          onboardingRouterFactory: onboardingRouterFactory)
    }
}
