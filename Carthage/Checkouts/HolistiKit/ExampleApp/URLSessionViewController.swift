import UIKit
import UIKitFringes

class URLSessionViewController: UITableViewController, URLSessionViewControlling, UITextViewDelegate {

    var interactor: URLSessionInteractor!

    @IBOutlet private weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44

        interactor.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.didTap(rowAt: indexPath)
    }

    func set(title text: String) {
        title = text
    }

    func set(data text: String, animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.textView.text = text
            self?.resizeTextView(animated: animated)
        }
    }

    private func resizeTextView(animated: Bool) {
        UIView.performWithAnimation(animated) { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
}

protocol URLSessionViewControlling: class, ViewControlling {

    func set(title text: String)
    func set(data text: String, animated: Bool)
}
