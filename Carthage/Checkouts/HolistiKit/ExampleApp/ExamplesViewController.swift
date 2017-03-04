import UIKit
import UIKitFringes

class ExamplesViewController: UITableViewController, ExamplesViewControlling {

    var interactor: ExamplesInteractor!
    private static let cellIdentifier = "ExamplesCell"

    @IBOutlet private weak var firstRow: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
    
    func set(title text: String) {
        title = text
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).cellIdentifier,
                                                 for: indexPath)
        let config = interactor.cellConfiguration(for: indexPath)
        cell.textLabel?.text = config.title
        cell.accessoryType = config.accessoryType
        return cell
    }

    override func tableView(_: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return interactor.numberOfRows
    }

    override func tableView(_: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        interactor.tap(rowAt: indexPath)
    }
}

protocol ExamplesViewControlling: class, ViewControlling {

    func set(title: String)
}
