@testable import SpecUIKitFringes

class RecordingSpecNavigationController: SpecNavigationController {

    enum Event {
        case viewDidLoad
        case viewWillAppear
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
    }

    private(set) var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        add(event: .viewDidLoad)
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        add(event: .viewWillAppear)
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        add(event: .viewDidAppear)
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        add(event: .viewWillDisappear)
    }

    override func viewDidDisappear() {
        super.viewDidDisappear()
        add(event: .viewDidDisappear)
    }

    private func add(event: Event) {
        events.append(event)
    }
}
