import XCTest
import CoreLocation
import FakeLocationManager

class LocationServicesTests: FakeLocationManagerTestCase {

    func test_WhenStatusAuthorizedWhenInUse_ThenLocationServicesOff() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        
        // user turns location services off
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        // authorization status is now exposed as .denied
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
