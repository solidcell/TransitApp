import Quick
import Nimble
@testable import TransitApp

class MapSourceManagerSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapSourceManager!

        beforeEach {
            subject = MapSourceManager(realm: self.realm)
        }

        describe("source") {
            it("returns the current Source") {
                expect(subject.source).to(equal(MapSourceManager.Source.door2door))
            }

            it("notifies the delegate when set") {
                let delegate = DelegateImplementation()
                expect(delegate.calledUpdateWith).to(beNil())
                
                subject.delegate = delegate
                expect(delegate.calledUpdateWith).to(equal(MapSourceManager.Source.door2door))

                subject.source = .coup
                expect(delegate.calledUpdateWith).to(equal(MapSourceManager.Source.coup))
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

private class DelegateImplementation: MapSourceManagerDelegate {
    
    var calledUpdateWith: MapSourceManager.Source?
    
    func didUpdate(source: MapSourceManager.Source) {
        self.calledUpdateWith = source
    }
    
}
