import UIKit
import UIKitFringes

class TimerViewController: UITableViewController, TimerViewControlling {

    var interactor: TimerInteractor!
    
    @IBOutlet private weak var dateCell: UITableViewCell!
    
    func set(title text: String) {
        title = text
    }
    
    func set(dateLabel text: String) {
        dateCell.textLabel?.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
}

protocol TimerViewControlling: class, ViewControlling {
    
    func set(title text: String)
    func set(dateLabel text: String)
}
