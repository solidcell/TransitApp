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

    func test_WhenLocationServicesIsOff() {
        // when Location Services are off
        subject.setLocationServicesEnabledInSettingsApp(false)
        // status is .denied
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
