import Quick
import Nimble
@testable import TransitApp

class SegmentedControlSourceSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var mapSourceManager: MapSourceManager!
        var subject: SegmentedControlSource!

        beforeEach {
            mapSourceManager = MapSourceManager(realm: self.realm)
            subject = SegmentedControlSource(mapSourceManager: mapSourceManager)
        }

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

            it("notifies the source manager") {
                expect(mapSourceManager.source.rawValue).to(equal(MapSourceManager.Source.door2door.rawValue))
                subject.selectIndex(0)
                expect(mapSourceManager.source.rawValue).to(equal(MapSourceManager.Source.coup.rawValue))
            }
            
        }
    }
}
