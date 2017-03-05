import XCTest

class MapRegionFeature: TransitAppFeature {

    func testInitialRegion() {
        XCTAssertNotNil(self.mapView.mapRegion)
    }
}
