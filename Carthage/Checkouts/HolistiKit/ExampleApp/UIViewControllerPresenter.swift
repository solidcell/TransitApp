import UIKitFringes

class UIViewControllerPresenter {
    
    fileprivate let router: ExamplesRouter
    fileprivate weak var viewController: UIViewControllerViewControlling!

    init(router: ExamplesRouter) {
        self.router = router
    }

    func set(viewController: UIViewControllerViewControlling) {
        self.viewController = viewController
    }
    
    func set(title text: String) {
        viewController.set(title: text)
    }

    func presentUIViewController() {
        router.navigate(to: .uiViewController, by: .present(self))
    }
}

extension UIViewControllerPresenter: PresentingPresenter {

    func present(viewController: ViewControlling) {
        self.viewController?.present(viewController: viewController)
    }
}
