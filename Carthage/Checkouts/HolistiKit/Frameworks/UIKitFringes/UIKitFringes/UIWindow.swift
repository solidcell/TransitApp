import UIKit

extension UIWindow: Windowing {

    public var asUIWindow: UIWindow { return self }

    public func set(rootViewController: ViewControlling) {
        self.rootViewController = rootViewController.asUIViewController
    }
}

public protocol Windowing {

    var asUIWindow: UIWindow { get }
    func set(rootViewController: ViewControlling)
}
