import UIKitFringes

class ExamplesRouter {

    private let examplesModuleFactory: ExamplesModuleFactory
    private let dateModuleFactory: DateModuleFactory
    private let timerModuleFactory: TimerModuleFactory
    private let urlSessionModuleFactory: URLSessionModuleFactory
    private let examplesNavigationModuleFactory: ExamplesNavigationModuleFactory
    private let uiViewControllerModuleFactory: UIViewControllerModuleFactory
    private let clLocationManagerModuleFactory: CLLocationManagerModuleFactory

    init(examplesNavigationModuleFactory: ExamplesNavigationModuleFactory,
         examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory,
         clLocationManagerModuleFactory: CLLocationManagerModuleFactory) {
        self.examplesNavigationModuleFactory = examplesNavigationModuleFactory
        self.examplesModuleFactory = examplesModuleFactory
        self.timerModuleFactory = timerModuleFactory
        self.urlSessionModuleFactory = urlSessionModuleFactory
        self.dateModuleFactory = dateModuleFactory
        self.uiViewControllerModuleFactory = uiViewControllerModuleFactory
        self.clLocationManagerModuleFactory = clLocationManagerModuleFactory
    }

    func present(onWindow window: Windowing) {
        let examplesViewController = examplesModuleFactory.create(withRouter: self)
        let examplesNavigationViewController = examplesNavigationModuleFactory.create(rootViewController: examplesViewController)
        window.set(rootViewController: examplesNavigationViewController)
    }

    enum ModuleIdentifier {
        case uiViewController
        case date
        case urlSession
        case timer
        case clLocationManager
    }

    enum SegueInfo {
        case present(PresentingPresenter)
        case push(PushingPresenter)
    }

    func navigate(to module: ModuleIdentifier, by segue: SegueInfo) {
        let vc = viewController(for: module)
        switch segue {
        case .present(let presenter): presenter.present(viewController: vc)
        case .push(let presenter): presenter.push(viewController: vc)
        }
    }

    private func viewController(for module: ModuleIdentifier) -> ViewControlling {
        switch module {
        case .uiViewController: return uiViewControllerModuleFactory.create(withRouter: self)
        case .date: return dateModuleFactory.create()
        case .urlSession: return urlSessionModuleFactory.create()
        case .timer: return timerModuleFactory.create()
        case .clLocationManager: return clLocationManagerModuleFactory.create()
        }
    }
}

class ExamplesRouterFactory {
    
    private let examplesNavigationModuleFactory: ExamplesNavigationModuleFactory
    private let examplesModuleFactory: ExamplesModuleFactory
    private let timerModuleFactory: TimerModuleFactory
    private let urlSessionModuleFactory: URLSessionModuleFactory
    private let dateModuleFactory: DateModuleFactory
    private let uiViewControllerModuleFactory: UIViewControllerModuleFactory
    private let clLocationManagerModuleFactory: CLLocationManagerModuleFactory

    init(examplesNavigationModuleFactory: ExamplesNavigationModuleFactory,
         examplesModuleFactory: ExamplesModuleFactory,
         timerModuleFactory: TimerModuleFactory,
         urlSessionModuleFactory: URLSessionModuleFactory,
         dateModuleFactory: DateModuleFactory,
         uiViewControllerModuleFactory: UIViewControllerModuleFactory,
         clLocationManagerModuleFactory: CLLocationManagerModuleFactory) {
        self.examplesNavigationModuleFactory = examplesNavigationModuleFactory
        self.examplesModuleFactory = examplesModuleFactory
        self.timerModuleFactory = timerModuleFactory
        self.urlSessionModuleFactory = urlSessionModuleFactory
        self.dateModuleFactory = dateModuleFactory
        self.uiViewControllerModuleFactory = uiViewControllerModuleFactory
        self.clLocationManagerModuleFactory = clLocationManagerModuleFactory
    }

    func create() -> ExamplesRouter {
        return ExamplesRouter(examplesNavigationModuleFactory: examplesNavigationModuleFactory,
                              examplesModuleFactory: examplesModuleFactory,
                              timerModuleFactory: timerModuleFactory,
                              urlSessionModuleFactory: urlSessionModuleFactory,
                              dateModuleFactory: dateModuleFactory,
                              uiViewControllerModuleFactory: uiViewControllerModuleFactory,
                              clLocationManagerModuleFactory: clLocationManagerModuleFactory)
    }
}
