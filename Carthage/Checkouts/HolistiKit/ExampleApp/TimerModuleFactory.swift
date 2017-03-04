import UIKitFringes

class TimerModuleFactory {
    
    private let viewControllerFactory: TimerViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding
    private let timerFactory: TimerFactoryProtocol
    
    init(viewControllerFactory: TimerViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding,
         timerFactory: TimerFactoryProtocol) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
        self.timerFactory = timerFactory
    }

    func create() -> ViewControlling {
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        let presenter = TimerPresenter(datePrinter: datePrinter)
        let interactor = TimerInteractor(dateProvider: dateProvider,
                                         timerFactory: timerFactory,
                                         presenter: presenter)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
