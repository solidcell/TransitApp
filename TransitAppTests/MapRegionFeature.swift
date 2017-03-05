import XCTest

class MapRegionFeature: TransitAppFeature {

    func testInitialRegion() {
        XCTAssertNotNil(mapView.mapRegion)
    }
}
