import Foundation
import UIKitFringes

class TimerInteractor {

    private let dateProvider: DateProviding
    private let timer: Timing
    private let timerInterval: TimeInterval = 1
    private let presenter: TimerPresenter

    init(dateProvider: DateProviding,
         timerFactory: TimerFactoryProtocol,
         presenter: TimerPresenter) {
        self.dateProvider = dateProvider
        self.presenter = presenter
        self.timer = timerFactory.create()
    }

    func viewDidLoad() {
        presenter.set(title: "Timer")
        startUpdatingDate()
    }

    private func startUpdatingDate() {
        updateDate()
        timer.start(interval: timerInterval, repeats: true) { [weak self] in
            self?.updateDate()
        }
    }

    private func updateDate() {
        presenter.updateWith(date: dateProvider.date)
    }
}
