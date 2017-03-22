import UIKit

extension UIWindow {

    var topmostViewController: UIViewController {
        return rootViewController!.topmostViewController
    }
}
