import SpecUIKitFringes
@testable import ExampleApp

class SpecURLSessionViewControllerFactory: URLSessionViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: URLSessionInteractor) -> URLSessionViewControlling {
        return SpecURLSessionViewController(interactor: interactor)
    }
}

protocol SpecURLSessionViewControllerUI {

    // Input
    func tapRequestJSON()
    func tapRequestHTML()
    // Output
    var title: String? { get }
    var dataLabel: SpecURLSessionViewController.DataLabel? { get }
}

class SpecURLSessionViewController: SpecViewController, URLSessionViewControlling, SpecURLSessionViewControllerUI {

    private(set) var title: String?
    private(set) var dataLabel: DataLabel?
    private let interactor: URLSessionInteractor

    struct DataLabel {
        let text: String
        let animated: Bool
    }

    init(interactor: URLSessionInteractor) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func tapRequestJSON() { tap(row: 0) }
    func tapRequestHTML() { tap(row: 1) }

    func set(title text: String) {
        title = text
    }

    func set(data text: String, animated: Bool) {
        dataLabel = DataLabel(text: text, animated: animated)
    }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        interactor.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

extension SpecURLSessionViewController.DataLabel: Equatable { }
func ==(lhs: SpecURLSessionViewController.DataLabel, rhs: SpecURLSessionViewController.DataLabel) -> Bool {
    return lhs.text == rhs.text &&
        lhs.animated == rhs.animated
}
