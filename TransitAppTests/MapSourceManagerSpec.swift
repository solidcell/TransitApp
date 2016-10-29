
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

        describe("sources") {
            it("returns an Iterator of all the Sources") {
                let expectedSources: [MapSourceManager.Source] = [.coup, .door2door]
                
                expect(subject.sources).to(contain(expectedSources))
                expect(Array(subject.sources)).to(haveCount(expectedSources.count))
            }
        }
    }
}
