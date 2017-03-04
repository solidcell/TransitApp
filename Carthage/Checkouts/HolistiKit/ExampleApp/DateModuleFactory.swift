import UIKitFringes

class DateModuleFactory {
    
    private let viewControllerFactory: DateViewControllerFactoryProtocol
    private let dateProvider: DateProviding
    private let timeZoneProvider: TimeZoneProviding

    init(viewControllerFactory: DateViewControllerFactoryProtocol,
         dateProvider: DateProviding,
         timeZoneProvider: TimeZoneProviding) {
        self.viewControllerFactory = viewControllerFactory
        self.dateProvider = dateProvider
        self.timeZoneProvider = timeZoneProvider
    }

    func create() -> ViewControlling {
        let datePrinter = DatePrinter(timeZoneProvider: timeZoneProvider)
        let presenter = DatePresenter(datePrinter: datePrinter)
        let interactor = DateInteractor(presenter: presenter,
                                        dateProvider: dateProvider)
        let viewController = viewControllerFactory.create(withInteractor: interactor)
        presenter.set(viewController: viewController)
        return viewController
    }
}
