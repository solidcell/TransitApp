import Quick
import Nimble
@testable import TransitApp

class SegmentedControlSourceSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        let mapSourceManager = MapSourceManager(realm: realm)
        let subject = SegmentedControlSource(mapSourceManager: mapSourceManager)

        describe("segments") {
            it("returns all Segment structs") {
                let segments = subject.segments

                expect(segments.count).to(equal(2))

                let first = segments.first!
                expect(first.title).to(equal("COUP"))

                let second = segments[1]
                expect(second.title).to(equal("Door2Door"))
            }
        }

        describe("selectedIndex") {
            it("corresponds initially to the source in the source manager") {
                expect(subject.selectedIndex).to(equal(1))
            }
        }

        describe("selectIndex") {
            
            it("updates the currently selected index") {
                expect(subject.selectedIndex).to(equal(1))
                subject.selectIndex(0)
                expect(subject.selectedIndex).to(equal(0))
            }

            it("notifies the delegate") {
                let delegate = SegmentedControlSourceDelegateImplementation()
                subject.delegate = delegate

                expect(delegate.didCallSelectWith).to(beNil())
                subject.selectIndex(0)
                expect(delegate.didCallSelectWith).to(equal(MapSourceManager.Source.coup))
            }
            
        }
    }
}

private class SegmentedControlSourceDelegateImplementation: SegmentedControlSourceDelegate {
    var didCallSelectWith: MapSourceManager.Source?

    func didSelect(source: MapSourceManager.Source) {
        didCallSelectWith = source
    }
}
