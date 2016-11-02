import Quick
import Nimble
import MapKit
@testable import TransitApp

class MapRegionProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapRegionProvider!

        beforeEach {
            subject = MapRegionProvider()
        }

        describe("region") {

            it("successfully returns a region") {
                // simple check that the method returns without error
                _ = subject.region
            }

        }
    }
}
