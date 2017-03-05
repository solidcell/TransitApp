import XCTest

class MapOverlayFeature: TransitAppFeature {

    func testIsSeeded() {
        XCTAssertEqual(mapView.mapOverlays.count, 3)
    }
}
