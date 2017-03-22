import UIKit

extension UINavigationController {

    override var topmostViewController: UIViewController {
        return nextViewController?.topmostViewController ?? topViewController!.topmostViewController
    }
}
