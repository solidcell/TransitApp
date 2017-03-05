import XCTest
import MapKit
@testable import TransitApp

class MapOverlayProviderSpec: TransitAppSpec {

    func testOverlaysReturnsAnOverlayForEachBusinessArea() {

        let coordinates = [CLLocationCoordinate2D(latitude: 44.0, longitude: 62.0),
                           CLLocationCoordinate2D(latitude: 40.0, longitude: 60.0),
                           CLLocationCoordinate2D(latitude: 50.0, longitude: 70.0)]
        let businessArea = BusinessArea(coordinates: coordinates)

        let subject = MapOverlayProvider(businessAreas: [businessArea])

        XCTAssertEqual(subject.overlays.count, 1)

        let overlay = subject.overlays.first as! MKPolygon
        XCTAssertEqual(overlay.pointCount, 3)

        let firstMapPoint = overlay.points()[0]
        let firstCoordinate = MKCoordinateForMapPoint(firstMapPoint)
        XCTAssertEqualWithAccuracy(firstCoordinate.latitude, 44.0, accuracy: 0.00000001)
        XCTAssertEqualWithAccuracy(firstCoordinate.longitude, 62.0, accuracy: 0.00000001)
    }
}
