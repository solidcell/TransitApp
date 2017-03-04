import UIKitFringes

class DatePresenter {

    fileprivate let datePrinter: DatePrinter
    fileprivate weak var viewController: DateViewControlling!

    func set(viewController: DateViewControlling) {
        self.viewController = viewController
    }

    init(datePrinter: DatePrinter) {
        self.datePrinter = datePrinter
    }

    func updateWith(date: Date) {
        let formattedDate = datePrinter.string(for: date, withFormat: .long)
        viewController.set(dateLabel: formattedDate)
    }
    
    func set(title text: String) {
        viewController.set(title: text)
    }
}
