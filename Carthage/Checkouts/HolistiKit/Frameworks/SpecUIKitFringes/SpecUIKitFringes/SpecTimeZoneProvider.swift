import Foundation
import UIKitFringes

public class SpecTimeZoneProvider: TimeZoneProviding {

    public init() { }
    
    public lazy var timeZone: TimeZone = {
        return TimeZone(abbreviation: "BRT")!
    }()
}
