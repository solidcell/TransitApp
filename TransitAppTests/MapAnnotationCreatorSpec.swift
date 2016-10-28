import Quick
import Nimble
import RealmSwift
import MapKit
@testable import TransitApp

class MapAnnotationCreatorSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        let subject = MapAnnotationCreator()

        describe("annotations(stops:)") {
            it("returns a MapAnnotation for each Stop") {
                let stop1 = Stop(name: "name 1", latitude: 1.0, longitude: 2.0)
                let stop2 = Stop(name: "name 2", latitude: 100.0, longitude: 200.0)
                try! self.realm.write {
                    self.realm.add([stop1, stop2])
                }
                let results = self.realm.stops

                let annotations = subject.annotations(stops: results)

                expect(annotations.count).to(equal(2))

                let first = annotations.first!
                expect(first.title).to(equal("name 1"))
                expect(first.locationName).to(equal("name 1"))
                expect(first.discipline).to(equal("name 1"))
                expect(first.coordinate).to(equal(CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)))

                let second = annotations[1]
                expect(second.title).to(equal("name 2"))
                expect(second.locationName).to(equal("name 2"))
                expect(second.discipline).to(equal("name 2"))
                expect(second.coordinate).to(equal(CLLocationCoordinate2D(latitude: 100.0, longitude: 200.0)))
            }
        }
    }
}
