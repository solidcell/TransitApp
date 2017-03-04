import XCTest
import CoreLocation
@testable import SpecUIKitFringes

class LocationUpdatingTests: SpecLocationManagerTestCase {

    func test_requestLocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)

        subject.requestLocation()
        userLocation.userIsInBerlin()

        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
    }

    func test_requestLocation_WhileNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.requestLocation()

        XCTAssertNotNil(delegate.receivedError)
    }

    func test_startUpdatingLocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        subject.startUpdatingLocation()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
        
        userLocation.userIsInBerlin()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        
        userLocation.userIsInBerlin()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 2)
    }

    func test_startUpdatingLocation_WhileNotDetermined() {
        XCTAssertEqual(subject.authorizationStatus(), .notDetermined)
        XCTAssertNil(delegate.receivedError)

        subject.startUpdatingLocation()

        XCTAssertNil(delegate.receivedError)
    }

    func test_location_BeforeHavingEverReceivedALocation() {
        XCTAssertNil(subject.location)
    }

    func test_location_AfterHavingReceivedALocationBefore() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        subject.requestLocation()
        userLocation.userIsInBerlin()
        
        XCTAssertNotNil(subject.location)
    }

    func test_receivingLocation_WithoutWantingLocation() {
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        userLocation.userIsInBerlin()
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 0)
    }
}
