import XCTest
import CoreLocation
import FakeLocationManager

class RequestingAuthorizationTests: FakeLocationManagerTestCase {
    
    func test_WhenStatusNotDetermined_ThenAllowed() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertEqual(subject.dialog, .requestAccessWhileInUse)
        
        subject.tapAllowInDialog()
        
        XCTAssertNil(subject.dialog)
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
    }
    
    func test_WhenStatusNotDetermined_ThenNotAllowed() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertEqual(subject.dialog, .requestAccessWhileInUse)
        
        subject.tapDoNotAllowAccessInDialog()
        
        XCTAssertNil(subject.dialog)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
    }
    
    func test_WhenStatusDenied() {
        subject.setAuthorizationStatusInSettingsApp(.denied)
        delegate.receivedAuthorizationChange = nil
        
        subject.requestWhenInUseAuthorization()

        XCTAssertNil(subject.dialog)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }
    
    func test_WhenStatusAuthorizedWhenInUse() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertNil(subject.dialog)
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }

    func test_WhenStatusNotDetermined_AndLocationServicesOff() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        subject.setLocationServicesEnabledInSettingsApp(false)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(subject.dialog)
    }

    func test_WhenStatusAuthorizedWhenInUse_AndLocationServicesOff_ThenOn() {
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)
        subject.setLocationServicesEnabledInSettingsApp(false)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.tapSettingsOrCancelInDialog()
        
        XCTAssertNil(subject.dialog)
        
        subject.setLocationServicesEnabledInSettingsApp(true)
        
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
    }

    func test_WhenStatusAuthorizedDenied_AndLocationServicesOff() {
        subject.setAuthorizationStatusInSettingsApp(.denied)
        subject.setLocationServicesEnabledInSettingsApp(false)
        delegate.receivedAuthorizationChange = nil

        subject.requestWhenInUseAuthorization()

        XCTAssertNil(subject.dialog)
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        XCTAssertNil(delegate.receivedAuthorizationChange)
    }

    func test_tappingAllowInDialogWhenNotPrompted() {
        XCTAssertNil(subject.dialog)
        
        subject.fatalErrorsOff() {
            subject.tapAllowInDialog()
            XCTAssertEqual(subject.erroredWith, .noDialog)
        }
    }

    func test_tappingAllowInDialogWhenWrongDialog() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.fatalErrorsOff() {
            subject.tapAllowInDialog()
            XCTAssertEqual(subject.erroredWith, .noRequestPermissionDialog)
        }
    }

    func test_tappingDoNotAllowInDialogWhenNotPrompted() {
        XCTAssertNil(subject.dialog)
        
        subject.fatalErrorsOff() {
            subject.tapDoNotAllowAccessInDialog()
            XCTAssertEqual(subject.erroredWith, .noDialog)
        }
    }

    func test_tappingDoNotAllowInDialogWhenWrongDialog() {
        subject.setLocationServicesEnabledInSettingsApp(false)
        subject.requestWhenInUseAuthorization()
        XCTAssertEqual(subject.dialog, .requestJumpToLocationServicesSettings)
        
        subject.fatalErrorsOff() {
            subject.tapDoNotAllowAccessInDialog()
            XCTAssertEqual(subject.erroredWith, .noRequestPermissionDialog)
        }
    }
    
}
