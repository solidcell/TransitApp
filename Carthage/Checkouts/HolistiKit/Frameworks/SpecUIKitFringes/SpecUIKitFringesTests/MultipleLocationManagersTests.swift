import XCTest
import UIKitFringes
@testable import SpecUIKitFringes

class MultipleLocationManagersTests: SpecLocationManagerTestCase {

    var subject2: LocationManaging!
    var delegate2: SpecLocationManagerDelegate!

    override func setUp() {
        super.setUp()
        
        subject2 = factory.create()
        delegate2 = SpecLocationManagerDelegate()
        subject2.delegate = delegate2
    }

    func test_authorizationStatusIsShared() {
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)
        
        XCTAssertEqual(subject.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(subject2.authorizationStatus(), .authorizedWhenInUse)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .authorizedWhenInUse)
        XCTAssertEqual(delegate2.receivedAuthorizationChange, .authorizedWhenInUse)
    }

    func test_locationServicesEnabledStatusIsShared() {
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)

        settingsApp.set(locationServicesEnabled: false)
        
        XCTAssertEqual(subject.authorizationStatus(), .denied)
        XCTAssertEqual(subject2.authorizationStatus(), .denied)
        XCTAssertEqual(delegate.receivedAuthorizationChange, .denied)
        XCTAssertEqual(delegate2.receivedAuthorizationChange, .denied)
    }

    func test_locationIsShared() {
        subject.requestWhenInUseAuthorization()
        dialogManager.tap(.allow)

        subject.requestLocation()
        subject2.requestLocation()
        userLocation.userIsInBerlin()
        
        XCTAssertEqual(delegate.receivedUpdatedLocations.count, 1)
        XCTAssertEqual(delegate2.receivedUpdatedLocations.count, 1)
    }
}
