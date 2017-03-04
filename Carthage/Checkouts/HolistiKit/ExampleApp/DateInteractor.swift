import Foundation
import UIKitFringes

class DateInteractor {

    private let presenter: DatePresenter
    private let dateProvider: DateProviding

    init(presenter: DatePresenter,
         dateProvider: DateProviding) {
        self.presenter = presenter
        self.dateProvider = dateProvider
    }
    
    func viewDidLoad() {
        presenter.set(title: "Date")
        presenter.updateWith(date: dateProvider.date)
    }
}
