import Quick
import Nimble

class MapOverlayFeature: TransitAppFeature { override func spec() {
    super.spec()

    it("is seeded with 3 business areas") {
        expect(self.mapView.mapOverlays).to(haveCount(3))
    }
    }
}
