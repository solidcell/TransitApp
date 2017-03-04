import UIKitFringes

public class SpecTimerFactory: TimerFactoryProtocol {

    private let dateProvider: SpecDateProvider

    public init(dateProvider: SpecDateProvider) {
        self.dateProvider = dateProvider
    }

    public func create() -> Timing {
        return SpecScheduledTimer(dateProvider: dateProvider)
    }
}
