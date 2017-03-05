import XCTest

class MapOverlayFeature: TransitAppFeature {

    func testIsSeeded() {
        XCTAssertEqual(self.mapView.mapOverlays.count, 3)
    }
}
