import XCTest
import CoreLocation
import MapKit

class MapRegionFeature: TransitAppFeature {

    func testInitialRegion() {
        tapAppIcon()
        let region = mapViewController.mapRegion!
        let expectedRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 52.52, longitude: 13.4145),
                                                                10000, 10000)
        XCTAssertEqual(region, expectedRegion)
    }
}
