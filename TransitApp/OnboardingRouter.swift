import UIKit

class OnboardingRouter {
    
    private let onboardingModuleFactory: OnboardingModuleFactory
    private let rootRouter: RootRouter

    init(onboardingModuleFactory: OnboardingModuleFactory,
         rootRouter: RootRouter) {
        self.onboardingModuleFactory = onboardingModuleFactory
        self.rootRouter = rootRouter
    }

    var viewController: UIViewController {
        return onboardingModuleFactory.create(router: self)
    }

    func presentMap(on presenter: UIViewController) {
        rootRouter.presentMap(on: presenter)
    }
}

class OnboardingRouterFactory {
    
    private let onboardingModuleFactory: OnboardingModuleFactory

    init(onboardingModuleFactory: OnboardingModuleFactory) {
        self.onboardingModuleFactory = onboardingModuleFactory
    }

    func create(rootRouter: RootRouter) -> OnboardingRouter {
        return OnboardingRouter(onboardingModuleFactory: onboardingModuleFactory,
                                rootRouter: rootRouter)
    }
}
