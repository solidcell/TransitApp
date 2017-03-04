import SpecUIKitFringes
@testable import ExampleApp

class SpecDateViewControllerFactory: DateViewControllerFactoryProtocol {

    func create(withInteractor interactor: DateInteractor) -> DateViewControlling {
        return SpecDateViewController(interactor: interactor)
    }
}

protocol SpecDateViewControllerUI {

    var dateLabel: String? { get }
    var title: String? { get }
}

class SpecDateViewController: SpecViewController, DateViewControlling, SpecDateViewControllerUI {

    private(set) var dateLabel: String?
    private(set) var title: String?
    private let interactor: DateInteractor

    init(interactor: DateInteractor) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(dateLabel text: String) {
        dateLabel = text
    }

    func set(title text: String) {
        title = text
    }
}
