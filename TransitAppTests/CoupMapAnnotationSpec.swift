import Quick
import Nimble
import MapKit
@testable import TransitApp

class CoupMapAnnotationSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: CoupMapAnnotation!

        describe("init") {

            beforeEach {
                let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                      energyLevel: 70, licensePlate: "123abc")
                subject = CoupMapAnnotation(scooter: scooter)
            }

            it("creates a configured annotation") {
                expect(subject.title).to(equal("123abc"))
                expect(subject.coordinate).to(equal(CLLocationCoordinate2D(latitude: 50.0,
                                                                           longitude: 60.0)))
                expect(subject.subtitle).to(equal("70%"))
            }

        }
    }
}

