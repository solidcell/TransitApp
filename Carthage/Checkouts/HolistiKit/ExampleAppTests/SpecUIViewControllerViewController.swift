import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecUIViewControllerViewControllerFactory: UIViewControllerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: UIViewControllerInteractor) -> UIViewControllerViewControlling {
        return SpecUIViewControllerViewController(interactor: interactor)
    }
}

protocol SpecUIViewControllerViewControllerUI {

    // Input
    func tapPresentViewController()
    // Output
    var title: String? { get }
    var presentedViewControlling: ViewControlling? { get }
}

class SpecUIViewControllerViewController: SpecViewController, UIViewControllerViewControlling, SpecUIViewControllerViewControllerUI {

    private(set) var title: String?
    private let interactor: UIViewControllerInteractor

    init(interactor: UIViewControllerInteractor) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func tapPresentViewController() { tap(row: 0) }

    private func tap(row: Int) {
        let ip = indexPath(forRow: row)
        interactor.didTap(rowAt: ip)
    }

    private func indexPath(forRow row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
