import Foundation

public class TimeZoneProvider: TimeZoneProviding {

    public init() { }

    public var timeZone: TimeZone {
        return TimeZone.current
    }
}

public protocol TimeZoneProviding {
    
    var timeZone: TimeZone { get }
}
