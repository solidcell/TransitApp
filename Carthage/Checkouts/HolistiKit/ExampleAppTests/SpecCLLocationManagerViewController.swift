import SpecUIKitFringes
import UIKitFringes
@testable import ExampleApp

class SpecCLLocationManagerViewControllerFactory: CLLocationManagerViewControllerFactoryProtocol {
    
    func create(withInteractor interactor: CLLocationManagerInteractor) -> CLLocationManagerViewControlling {
        return SpecCLLocationManagerViewController(interactor: interactor)
    }
}

protocol SpecCLLocationManagerViewControllerUI {

    // Input
    func tapRequestAuthorizationRow()
    // Output
    var title: String? { get }
    var authorizationStatus: String? { get }
}

class SpecCLLocationManagerViewController: SpecViewController, CLLocationManagerViewControlling, SpecCLLocationManagerViewControllerUI {

    private(set) var title: String?
    private(set) var authorizationStatus: String?
    private let interactor: CLLocationManagerInteractor

    init(interactor: CLLocationManagerInteractor) {
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func tapRequestAuthorizationRow() {
        interactor.didTap(rowAt: IndexPath(row: 0, section: 1))
    }

    func set(title text: String) {
        title = text
    }

    func set(authorizationStatus text: String) {
        authorizationStatus = text
    }
}
