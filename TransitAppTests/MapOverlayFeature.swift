import Quick
import Nimble

class MapOverlayFeature: TransitAppFeature {

    func testIsSeeded() {
        XCTAssertEqual(self.mapView.mapOverlays.count, 3)
    }
}
