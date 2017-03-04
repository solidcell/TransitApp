import XCTest
@testable import SpecUIKitFringes

class SpecSystemTestCase: XCTestCase {

    var subject: SpecSystem!
    var errorHandler: SpecErrorHandler!
    
    override func setUp() {
        super.setUp()
        errorHandler = SpecErrorHandler()
        subject = RecordingSpecSystem(errorHandler: errorHandler)
    }

    var appDelegate: RecordingSpecApplicationDelegate! {
        return subject.appDelegate as? RecordingSpecApplicationDelegate
    }
}
