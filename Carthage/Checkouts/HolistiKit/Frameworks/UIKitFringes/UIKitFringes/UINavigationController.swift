import UIKit

extension UINavigationController: NavigationControlling {
    
    public var asUINavigationController: UINavigationController { return self }

    public func push(viewController: ViewControlling, animated: Bool) {
        pushViewController(viewController.asUIViewController, animated: animated)
    }
}

public protocol NavigationControlling: ViewControlling {
    
    var asUINavigationController: UINavigationController { get }
    func push(viewController: ViewControlling, animated: Bool)
}
