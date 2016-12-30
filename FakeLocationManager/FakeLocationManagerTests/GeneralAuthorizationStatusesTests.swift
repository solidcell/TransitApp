import XCTest
import CoreLocation
import FakeLocationManager

class GeneralAuthorizationStatusesTests: FakeLocationManagerTestCase {

    func test_WhenStatusNotDetermined() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .notDetermined)
    }
    
}
