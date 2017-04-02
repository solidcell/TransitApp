import Foundation

class OnboardingPresenter {

    weak var viewController: OnboardingViewController!
    private let router: OnboardingRouter
    
    init(router: OnboardingRouter) {
        self.router = router
    }

    func presentMap() {
        router.presentMap(on: viewController)
    }
}
