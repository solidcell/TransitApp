import UIKit
import UIKitFringes

open class SpecViewController: ViewControlling {

    public init() { }

    public var navigationControlling: NavigationControlling? { return navigationController }
    public weak var navigationController: SpecNavigationController?
    
    public var presentedViewControlling: ViewControlling? { return presentedViewController }
    private var presentedViewController: SpecViewController?

    open func viewDidLoad() { }
    open func viewWillAppear() { }
    open func viewDidAppear() { }
    open func viewWillDisappear() { }
    open func viewDidDisappear() { }

    public func present(viewController: ViewControlling) {
        presentedViewController = viewController.asSpecViewController
        viewDisappear()
        presentedViewController!.viewLoadAndAppear()
    }

    public func push(viewController: ViewControlling, animated: Bool) {
        navigationControlling!.push(viewController: viewController, animated: animated)
    }

    func set(navigationController: SpecNavigationController) {
        self.navigationController = navigationController
    }

    var topViewController: SpecViewController {
        return nextViewController?.topViewController ?? self
    }

    var nextViewController: SpecViewController? {
        return presentedViewController
    }

    var viewControllerStack: [SpecViewController] {
        return (nextViewController?.viewControllerStack ?? []) + [self]
    }

    func viewLoadAndAppear() {
        viewDidLoad()
        viewAppear()
    }
    
    func viewAppear() {
        viewWillAppear()
        viewDidAppear()
    }

    func viewDisappear() {
        viewWillDisappear()
        viewDidDisappear()
    }

    public var asUIViewController: UIViewController {
        fatalError("This should never be called in tests")
    }
}

extension ViewControlling {

    var asSpecViewController: SpecViewController {
        return self as! SpecViewController
    }
}
