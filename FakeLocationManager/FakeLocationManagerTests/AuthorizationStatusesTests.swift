import XCTest
import CoreLocation
import FakeLocationManager

class AuthorizationStatusesTests: FakeLocationManagerTestCase {

    func test_WhenStatusNotDetermined() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .notDetermined)
    }

    func test_WhenStatusNotDetermined_ThenAuthorizedWhenInUse() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)

        // status is changed to .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        // status is .authorizedWhenInUse
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
    }

    func test_WhenStatusNotDetermined_ThenDenied() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        // status is changed to .denied
        subject.setAuthorizationStatusInSettingsApp(.denied)
        
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        // status is .denied
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
