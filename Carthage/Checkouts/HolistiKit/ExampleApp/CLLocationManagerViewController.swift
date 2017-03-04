import UIKit
import UIKitFringes

class CLLocationManagerViewController: UITableViewController, CLLocationManagerViewControlling {

    @IBOutlet private weak var authorizationStatusCell: UITableViewCell!

    var interactor: CLLocationManagerInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func set(authorizationStatus text: String) {
        authorizationStatusCell.textLabel?.text = text
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didTap(rowAt: indexPath)
    }
}

protocol CLLocationManagerViewControlling: class, ViewControlling {

    func set(title text: String)
    func set(authorizationStatus text: String)
}
