import Foundation
import UIKitFringes

class DatePrinter {

    enum Format: String {
        case long = "HH:mm:ss d MMMM yyyy"
    }

    private let timeZoneProvider: TimeZoneProviding

    init(timeZoneProvider: TimeZoneProviding) {
        self.timeZoneProvider = timeZoneProvider
    }

    func string(for date: Date, withFormat format: Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZoneProvider.timeZone
        return dateFormatter.string(from: date)
    }
    
}
