import Quick
import Nimble
@testable import TransitApp

class SegmentedControlSourceSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        let mapSourceManager = MapSourceManager()
        let subject = SegmentedControlSource(mapSourceManager: mapSourceManager)

        describe("segments") {
            it("returns all Segment structs") {
                let segments = subject.segments

                expect(segments.count).to(equal(2))

                let first = segments.first!
                expect(first.index).to(equal(0))
                expect(first.title).to(equal("COUP"))

                let second = segments[1]
                expect(second.index).to(equal(1))
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

                expect(delegate.didCallUpdateWith).to(beNil())
                subject.selectIndex(0)
                expect(delegate.didCallUpdateWith).to(equal(MapSourceManager.Source.coup))
            }
            
        }
    }
}

private class SegmentedControlSourceDelegateImplementation: SegmentedControlSourceDelegate {
    var didCallUpdateWith: MapSourceManager.Source?

    func didUpdate(source: MapSourceManager.Source) {
        didCallUpdateWith = source
    }
}
