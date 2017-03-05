import XCTest
import CoreLocation

class MapOverlayFeature: TransitAppFeature {

    func testIsSeeded() {
        XCTAssertEqual(mapView.businessAreaOverlays.count, 3)
        let first = mapView.businessAreaOverlays.first!
        let coordinates = first.coordinates
        XCTAssertEqual(coordinates.count, 9)
        XCTAssertEqual(coordinates.first,
                       CLLocationCoordinate2D(latitude: 52.4982496804861, longitude: 13.354353904724121))
    }
}
