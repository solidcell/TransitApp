import XCTest
import MapKit
@testable import TransitApp

class MapRegionProviderSpec: TransitAppSpec {
    
    func testRegionSuccessfullyReturnsARegion() {
        let subject = MapRegionProvider()

        // simple check that the method returns without error
        _ = subject.region
    }
}
