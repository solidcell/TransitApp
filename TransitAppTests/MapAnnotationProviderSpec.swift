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
            let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                  energyLevel: 70, licensePlate: "123abc")

            try! self.realm.write {
                self.realm.add(scooter)
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
