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

    func test_RespondToTheLocationServicesDialogTwice() {
        // location services is off
        subject.setLocationServicesEnabledInSettingsApp(false)

        subject.requestWhenInUseAuthorization()
        // user is prompted with location services dialog the first time
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        // user taps any response
        subject.tapSettingsOrCancelInDialog()
        XCTAssertNil(subject.dialog)

        subject.requestWhenInUseAuthorization()
        // user is prompted with location services dialog the second time
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        // user taps any response
        subject.tapSettingsOrCancelInDialog()
        XCTAssertNil(subject.dialog)

        subject.requestWhenInUseAuthorization()
        // user is not prompted with location services dialog a third time
        XCTAssertNil(subject.dialog)
    }

    func test_respondingToDialogWhenItIsNotPresented() {
        subject.fatalErrorsOff() {
            subject.tapSettingsOrCancelInDialog()
        }
    }
    
}
