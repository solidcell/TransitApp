import XCTest
import CoreLocation
import FakeLocationManager

class GeneralAuthorizationStatusesTests: FakeLocationManagerTestCase {

    func test_WhenStatusNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .notDetermined)
    }

    func test_WhenLocationServicesIsOff() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }
    
}
