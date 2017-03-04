import UIKit
import UIKitFringes

class UIViewControllerViewController: UITableViewController, UIViewControllerViewControlling {
    
    var interactor: UIViewControllerInteractor!

    override func viewDidLoad() {
        interactor.viewDidLoad()
    }
    
    func set(title text: String) {
        title = text
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTap(rowAt: indexPath)
    }
}

protocol UIViewControllerViewControlling: class, ViewControlling {
    
    func set(title text: String)
}
