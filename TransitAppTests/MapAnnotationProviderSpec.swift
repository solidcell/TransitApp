import Quick
import Nimble
import RealmSwift
import MapKit
@testable import TransitApp

class MapAnnotationProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapAnnotationProvider!

        beforeEach {
            let stop1 = Stop(name: "name 1", latitude: 1.0, longitude: 2.0)
            let stop2 = Stop(name: "name 2", latitude: 100.0, longitude: 200.0)

            let scooter1 = Scooter(latitude: 50.0, longitude: 60.0,
                                   energyLevel: 70, licensePlate: "123abc")

            try! self.realm.write {
                self.realm.add([stop1, stop2, scooter1])
            }
        }

        describe("annotations") {

            beforeEach {
                subject = MapAnnotationProvider(realm: self.realm)
            }

            it("returns a CoupMapAnnotation for each Scooter") {
                let annotations = subject.annotations

                expect(annotations.count).to(equal(1))

                let first = annotations.first! as! CoupMapAnnotation
                expect(first.title).to(equal("123abc"))
                expect(first.coordinate).to(equal(CLLocationCoordinate2D(latitude: 50.0, longitude: 60.0)))
                expect(first.subtitle).to(equal("70%"))
            }
        }

    }
}
