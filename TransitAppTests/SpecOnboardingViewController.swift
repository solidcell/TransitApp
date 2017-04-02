import UIKit
@testable import TransitApp

protocol OnboardingUI {

    // Input
    func tapSkip()
}

class SpecOnboardingViewController: OnboardingViewController, OnboardingUI {
    
    func tapSkip() {
        didTapSkip()
    }
}

class SpecOnboardingViewControllerFactory: OnboardingViewControllerFactoryProtocol {

    func create() -> OnboardingViewController {
        return SpecOnboardingViewController()
    }
}
