import Foundation

class OnboardingInteractor {

    private let presenter: OnboardingPresenter

    init(presenter: OnboardingPresenter) {
        self.presenter = presenter
    }

    func didTapSkip() {
        presenter.presentMap()
    }
}
