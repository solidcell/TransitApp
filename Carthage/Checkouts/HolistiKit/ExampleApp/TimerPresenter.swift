import UIKitFringes

class TimerPresenter {

    private let datePrinter: DatePrinter
    private weak var viewController: TimerViewControlling!

    init(datePrinter: DatePrinter) {
        self.datePrinter = datePrinter
    }

    func set(viewController: TimerViewControlling) {
        self.viewController = viewController
    }
    
    func set(title text: String) {
        viewController.set(title: text)
    }

    func updateWith(date: Date) {
        let formattedDate = datePrinter.string(for: date, withFormat: .long)
        viewController.set(dateLabel: formattedDate)
    }
}
