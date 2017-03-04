import UIKit

extension UIViewController: ViewControlling {
    
    public var asUIViewController: UIViewController { return self }
    public var presentedViewControlling: ViewControlling? { return presentedViewController }
    public var navigationControlling: NavigationControlling? { return navigationController }

    public func present(viewController: ViewControlling) {
        present(viewController.asUIViewController, animated: true, completion: nil)
    }
}

public protocol ViewControlling {
    
    var asUIViewController: UIViewController { get }
    func present(viewController: ViewControlling)
    var presentedViewControlling: ViewControlling? { get }
    var navigationControlling: NavigationControlling? { get }
}
