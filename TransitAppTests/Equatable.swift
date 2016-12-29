@testable import TransitApp

typealias Handler = MapViewModel.Alert.Action.Handler

extension Handler : Equatable {
    
    static func ==(lhs: Handler, rhs: Handler) -> Bool {
        switch (lhs, rhs) {
        case (let .url(url1), let .url(url2)):
            return url1 == url2
        case (.noop, .noop):
            return true
        default:
            return false
        }
    }
    
}
