import UIKit
import UIKitFringes

public protocol SpecNavigationControllerUI {

    func tapBack()
}

open class SpecNavigationController: SpecViewController, NavigationControlling {

    fileprivate var viewControllers = [SpecViewController]()

    override var nextViewController: SpecViewController? {
        return viewControllers.last
    }

    override var topViewController: SpecViewController {
        return nextViewController!.topViewController
    }

    override public func push(viewController: ViewControlling, animated: Bool) {
        let viewController = viewController.asSpecViewController
        let previousTopViewController = viewControllers.last
        viewControllers.append(viewController)
        viewController.set(navigationController: self)
        if let previousTopViewController = previousTopViewController {
            previousTopViewController.viewDisappear()
        }
        viewController.viewLoadAndAppear()
    }

    public var asUINavigationController: UINavigationController { 
        fatalError("This should never be called in tests")
    }
}

extension SpecNavigationController: SpecNavigationControllerUI {

    public func tapBack() {
        if viewControllers.count < 2 {
            fatalError("There wouldn't be a back button since there aren't at least 2 view controllers in the stack.")
        }
        let poppedViewController = viewControllers.popLast()
        poppedViewController?.viewDisappear()
        viewControllers.last!.viewAppear()
    }
}
