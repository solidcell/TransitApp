import Quick
import Nimble

class MapRegionFeature: TransitAppFeature { override func spec() {
    super.spec()

    it("starts at an initial map region") {
        expect(self.mapView.mapRegion).toNot(beNil())
    }
    }
}
