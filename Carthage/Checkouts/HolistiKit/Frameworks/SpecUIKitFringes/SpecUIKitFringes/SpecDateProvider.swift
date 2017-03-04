import Foundation
import UIKitFringes

public class SpecDateProvider: DateProviding {

    private let notifier = SpecMulticaster()

    public init() { }

    public private(set) lazy var date: Date = {
        let initialDateString = "2016-08-23 00:00:00 +0000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: initialDateString)!
    }()

    public func progress(seconds: UInt) {
        for _ in 0..<seconds {
            date = date.addingTimeInterval(1)
            notifier.post()
        }
    }
    
    func observe(on observer: Any, selector: Selector) {
        notifier.observe(on: observer, selector: selector)
    }
}
