import UIKit
import UIKitFringes

public class SpecWindow: Windowing {

    public init() { }

    private(set) var rootViewController: SpecViewController?
    
    public func set(rootViewController: ViewControlling) {
        self.rootViewController = rootViewController.asSpecViewController
        self.rootViewController!.viewLoadAndAppear()
    }

    public var asUIWindow: UIWindow {
        fatalError("This should never be called in tests")
    }

    public var topViewController: SpecViewController {
        return rootViewController!.topViewController
    }

    public var viewControllerStack: [SpecViewController] {
        return rootViewController!.viewControllerStack
    }
}
    
