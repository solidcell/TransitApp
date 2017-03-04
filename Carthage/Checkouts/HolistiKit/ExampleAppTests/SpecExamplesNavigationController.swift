import SpecUIKitFringes
@testable import ExampleApp

class SpecExamplesNavigationControllerFactory: ExamplesNavigationControllerFactoryProtocol {

    func create() -> ExamplesNavigationControlling {
        return SpecExamplesNavigationController()
    }
}

protocol SpecExamplesNavigationControllerUI: SpecNavigationControllerUI {
}

class SpecExamplesNavigationController: SpecNavigationController, ExamplesNavigationControlling, SpecExamplesNavigationControllerUI {
}
