import Quick
import Nimble
import RealmSwift
import MapKit
@testable import TransitApp

class MapAnnotationCreatorSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapAnnotationCreator!

        beforeEach {
            let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                  energyLevel: 70, licensePlate: "123abc")
            
            try! self.realm.write {
                self.realm.add(scooter)
            }

            subject = MapAnnotationCreator()
        }

        describe("annotations") {

            it("creates an annotation per scooter") {
                let scooters = Array(self.realm.scooters)
                let annotations = subject.annotations(scooters: scooters)

                expect(annotations.count).to(equal(1))

                let first = annotations.first!
                expect(first.title).to(equal("123abc"))
                expect(first.coordinate).to(equal(CLLocationCoordinate2D(latitude: 50.0, longitude: 60.0)))
                expect(first.subtitle).to(equal("70%"))
            }

        }
    }
}

