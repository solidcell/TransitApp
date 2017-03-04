@testable import ExampleApp

class SpecErrorLogger: ErrorLogging {
    
    func log(_ message: String) {
        fatalError(message)
    }
}
