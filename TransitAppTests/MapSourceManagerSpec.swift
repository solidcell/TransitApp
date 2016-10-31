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
                expect(delegate.calledDidUpdateCount).to(equal(0))
                
                subject.delegate = delegate
                expect(delegate.calledDidUpdateCount).to(equal(1))

                subject.source = .coup
                expect(delegate.calledDidUpdateCount).to(equal(2))
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
    
    var calledDidUpdateCount = 0
    
    func didUpdate() {
        self.calledDidUpdateCount += 1
    }
    
}
