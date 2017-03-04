import Foundation

public class DateProvider: DateProviding {

    public init() { }

    public var date: Date {
        return Date()
    }
}


public protocol DateProviding {
    
    var date: Date { get }
}
