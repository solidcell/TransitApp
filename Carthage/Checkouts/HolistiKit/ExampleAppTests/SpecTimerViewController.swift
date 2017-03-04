import SpecUIKitFringes
@testable import ExampleApp

class SpecTimerViewControllerFactory: TimerViewControllerFactoryProtocol {

    func create(withInteractor interactor: TimerInteractor) -> TimerViewControlling {
        return SpecTimerViewController(interactor: interactor)
    }
}

protocol SpecTimerViewControllerUI {

    var title: String? { get }
    var dateLabel: String? { get }
}

class SpecTimerViewController: SpecViewController, TimerViewControlling, SpecTimerViewControllerUI {

    private(set) var title: String?
    private(set) var dateLabel: String?
    private let interactor: TimerInteractor

    init(interactor: TimerInteractor) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }

    func set(title text: String) {
        title = text
    }

    func set(dateLabel text: String) {
        dateLabel = text
    }
}
