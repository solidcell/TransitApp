import XCTest
import CoreLocation
import FakeLocationManager

class AuthorizationInSettingsAppTests: FakeLocationManagerTestCase {

    func test_WhenStatusNotDetermined_ThenAuthorizedWhenInUse() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)

        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
    }

    func test_WhenStatusNotDetermined_ThenDenied() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        subject.setAuthorizationStatusInSettingsApp(.denied)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
