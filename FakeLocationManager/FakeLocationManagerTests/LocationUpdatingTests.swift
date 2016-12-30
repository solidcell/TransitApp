import XCTest
import CoreLocation
import FakeLocationManager

class LocationUpdatingTests: FakeLocationManagerTestCase {

    func test_locationRequestSuccess_AfterRequestLocation() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        subject.requestLocation()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        subject.locationRequestSuccess()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        subject.fatalErrorsOff() {
            subject.locationRequestSuccess()
            XCTAssertEqual(subject.erroredWith, .noLocationRequestInProgress)
        }
    }

    func test_locationRequestSuccess_AfterStartUpdatingLocation() {
        // current status is .authorizedWhenInUse
        subject.setAuthorizationStatusInSettingsApp(.authorizedWhenInUse)

        subject.startUpdatingLocation()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        subject.locationRequestSuccess()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        subject.locationRequestSuccess()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 2)
    }

    func test_updatedLocationWithoutAuthorization() {
        subject.fatalErrorsOff() {
            subject.locationRequestSuccess()
            XCTAssertEqual(subject.erroredWith, .notAuthorized)
        }
    }
}
