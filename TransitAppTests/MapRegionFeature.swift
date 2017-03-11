import XCTest
import CoreLocation
import MapKit

class MapRegionFeature: TransitAppFeature {

    func testInitialRegion() {
        let region = mapView.mapRegion!
        let expectedRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 52.52, longitude: 13.4145),
                                                                23000, 23000)
        XCTAssertEqual(region, expectedRegion)
    }
}
