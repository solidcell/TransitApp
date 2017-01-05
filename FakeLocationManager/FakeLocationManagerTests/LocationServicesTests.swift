import XCTest
import CoreLocation
import FakeLocationManager

class LocationServicesTests: FakeLocationManagerTestCase {

    func test_WhenStatusAuthorizedWhenInUse_ThenLocationServicesOff() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        
        subject.setLocationServicesEnabledInSettingsApp(false)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
    }

    func test_RespondToTheLocationServicesDialogTwice() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(subject.dialog)
        
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(subject.dialog)
        
        subject.requestWhenInUseAuthorization()
        
        XCTAssertNil(subject.dialog)
    }

    func test_respondingToDialogWhenItIsNotPresented() {
        subject.fatalErrorsOff() {
            subject.tapSettingsOrCancelInDialog()
            XCTAssertEqual(subject.erroredWith, .noLocationServicesDialog)
        }
    }
    
}
