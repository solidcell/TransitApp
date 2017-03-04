import Foundation
import UIKitFringes

public class SpecScheduledTimer: Timing {

    public typealias TimerBlock = () -> Void

    private let dateProvider: SpecDateProvider
    private var block: TimerBlock?
    private var interval: TimeInterval?
    private var lastFiredDate: Date?

    public init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
        dateProvider.observe(on: self, selector: #selector(dateDidChange))
    }

    @objc
    func dateDidChange() {
        guard let lastFiredDate = lastFiredDate,
            let interval = interval,
            let block = block else { return }
        let currentDate = dateProvider.date
        let delta = currentDate.timeIntervalSince(lastFiredDate)
        if delta >= interval {
            self.lastFiredDate = currentDate
            block()
        }
    }

    public func start(interval: TimeInterval, repeats: Bool, block: @escaping TimerBlock) {
        self.interval = interval
        self.block = block
        self.lastFiredDate = dateProvider.date
    }
}
