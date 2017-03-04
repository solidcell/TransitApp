import UIKitFringes

class ExamplesNavigationPresenter {

    func set(viewController: ExamplesNavigationControlling, rootViewController: ViewControlling) {
        viewController.push(viewController: rootViewController, animated: false)
    }
}
