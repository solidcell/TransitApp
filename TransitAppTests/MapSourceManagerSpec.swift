
import Quick
import Nimble
@testable import TransitApp

class MapSourceManagerSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        let subject = MapSourceManager()

        describe("source") {
            it("returns the current Source") {
                expect(subject.source).to(equal(MapSourceManager.Source.door2door))
            }
        }
    }
}
