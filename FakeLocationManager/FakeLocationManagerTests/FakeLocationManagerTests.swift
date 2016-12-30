import XCTest
import CoreLocation
import FakeLocationManager

class FakeLocationManagerTests: FakeLocationManagerTestCase {

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
    
    func test_requestWhenInUseAuthorization_WhenStatusNotDetermined_ThenAllowed() {
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
    
    func test_requestWhenInUseAuthorization_WhenStatusNotDetermined_ThenNotAllowed() {
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
    
    func test_requestWhenInUseAuthorization_WhenStatusDenied() {
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
    
    func test_requestWhenInUseAuthorization_WhenStatusAuthorizedWhenInUse() {
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

    func test_requestWhenInUseAuthorization_WhenStatusNotDetermined_WhenLocationServicesOff() {
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

    func test_requestWhenInUseAuthorization_WhenStatusAuthorizedWhenInUse_WhenLocationServicesOff_ThenOn() {
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

    func test_requestWhenInUseAuthorization_WhenStatusAuthorizedDenied_WhenLocationServicesOff() {
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

    func test_locationRequestSuccess_AfterRequestLocation() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        subject.requestLocation()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        subject.locationRequestSuccess()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
    }

    func test_locationRequestSuccess_AfterStartUpdatingLocation() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        subject.startUpdatingLocation()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        subject.locationRequestSuccess()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
    }
}
