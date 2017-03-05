import XCTest
import MapKit
@testable import TransitApp

class CoupMapAnnotationSpec: TransitAppSpec {

    func testCreatesAConfiguredAnnotation() {
        let scooter = Scooter(coordinate: CLLocationCoordinate2D(latitude: 50.0, longitude: 60.0),
                              energyLevel: 70,
                              licensePlate: "123abc")
        let subject = CoupMapAnnotation(scooter: scooter)

        XCTAssertEqual(subject.title, "123abc")
        XCTAssertEqual(subject.coordinate, CLLocationCoordinate2D(latitude: 50.0,
            longitude: 60.0))
        XCTAssertEqual(subject.subtitle, "70%")
    }
}

