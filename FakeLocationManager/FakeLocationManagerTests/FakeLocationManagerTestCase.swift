import XCTest
import FakeLocationManager

class FakeLocationManagerTestCase: XCTestCase {

    var subject: FakeLocationManager!
    var delegate: SpecDelegate!
    
    override func setUp() {
        super.setUp()

        subject = FakeLocationManager()
        delegate = SpecDelegate()
        subject.delegate = delegate
    }
}
