import XCTest
import MapKit
@testable import TransitApp

class MapRegionProviderSpec: XCTestCase {
    
    func testRegionSuccessfullyReturnsARegion() {
        let subject = MapRegionProvider()

        // simple check that the method returns without error
        _ = subject.region
    }
}
