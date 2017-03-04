import Quick
import Nimble

class MapRegionFeature: TransitAppFeature {

    func testInitialRegion() {
        XCTAssertNotNil(self.mapView.mapRegion)
    }
}
