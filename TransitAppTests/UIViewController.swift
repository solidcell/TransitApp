import UIKit

extension UIViewController {

    var topmostViewController: UIViewController {
        return nextViewController?.topmostViewController ?? self
    }

    var nextViewController: UIViewController? {
        return presentedViewController
    }
}
