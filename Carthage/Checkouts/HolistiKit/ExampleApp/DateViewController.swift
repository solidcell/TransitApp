import UIKit
import UIKitFringes

class DateViewController: UITableViewController, DateViewControlling {

    var interactor: DateInteractor!
    
    @IBOutlet private weak var viewLoadedAtLabel: UITableViewCell!

    func set(dateLabel text: String) {
        viewLoadedAtLabel.textLabel?.text = text
    }
    
    func set(title text: String) {
        title = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
}

protocol DateViewControlling: class, ViewControlling {
    
    func set(dateLabel text: String)
    func set(title text: String)
}
