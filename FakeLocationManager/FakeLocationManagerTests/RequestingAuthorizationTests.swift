import XCTest
import CoreLocation
import FakeLocationManager

class RequestingAuthorizationTests: FakeLocationManagerTestCase {
    
    func test_WhenStatusNotDetermined_ThenAllowed() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is prompted with authorization dialog
        XCTAssertEqual(subject.dialog, .requestAccessWhileInUse)
        // user taps Allow
        subject.tapAllowInDialog()
        XCTAssertNil(subject.dialog)
        // updates authorization status
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
    }
    
    func test_WhenStatusNotDetermined_ThenNotAllowed() {
        // initial status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is prompted with authorization dialog
        XCTAssertEqual(subject.dialog, .requestAccessWhileInUse)
        // user taps Don't Allow
        subject.tapDoNotAllowAccessInDialog()
        XCTAssertNil(subject.dialog)
        // updates authorization status
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
    }
    
    func test_WhenStatusDenied() {
        // current status is .denied
        subject.setAuthorizationStatusInSettingsApp(.denied)
        delegate.receivedAuthorizationChange = nil
        
        subject.requestWhenInUseAuthorization()

        // user is not prompted with authorization dialog
        XCTAssertNil(subject.dialog)
        // authorization status stays the same
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        // does not notify delegate
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }
    
    func test_WhenStatusAuthorizedWhenInUse() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is not prompted with authorization dialog
        XCTAssertNil(subject.dialog)
        // authorization status stays the same
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        // does not notify delegate
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }

    func test_WhenStatusNotDetermined_AndLocationServicesOff() {
        // current status is .notDetermined
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        // location services is off
        subject.setLocationServicesEnabledInSettingsApp(false)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is prompted with location services dialog
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        // user taps any response
        subject.tapSettingsOrCancelInDialog()
        XCTAssertNil(subject.dialog)
    }

    func test_WhenStatusAuthorizedWhenInUse_AndLocationServicesOff_ThenOn() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        // location services is off
        subject.setLocationServicesEnabledInSettingsApp(false)
        // clear out last received delegate notification
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is prompted with location services dialog
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        // user taps any response
        subject.tapSettingsOrCancelInDialog()
        XCTAssertNil(subject.dialog)
        // user turns on location services
        subject.setLocationServicesEnabledInSettingsApp(true)
        // notifies delegate
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
    }

    func test_WhenStatusAuthorizedDenied_AndLocationServicesOff() {
        // current status is .denied
        subject.setAuthorizationStatusInSettingsApp(.denied)
        // location services is off
        subject.setLocationServicesEnabledInSettingsApp(false)
        // clear out last received delegate notification
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        // user is not prompted with location services dialog
        XCTAssertNil(subject.dialog)
        // authorization status stays the same
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        // does not notify delegate
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }

    func test_respondingToDialogWhenNotPrompted() {
        subject.fatalErrorsOff() {
            subject.tapAllowInDialog()
            XCTAssertEqual(subject.erroredWith, .noDialog)
        }
    }
    
}
