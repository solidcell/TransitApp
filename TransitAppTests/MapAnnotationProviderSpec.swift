import Quick
import Nimble
import RealmSwift
import MapKit
@testable import TransitApp

class MapAnnotationProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapAnnotationProvider!
        var dataSource: SpecDataSource!
        var delegate: SpecDelegate!

        beforeEach {
            let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                  energyLevel: 70, licensePlate: "123abc")

            try! self.realm.write {
                self.realm.add(scooter)
            }

            dataSource = SpecDataSource(results: self.realm.scooters)
            subject = MapAnnotationProvider(dataSource: dataSource)
            delegate = SpecDelegate()
        }

        describe("when setting the delegate") {

            beforeEach {
                expect(delegate.receivedAnnotations).to(beNil())

                subject.delegate = delegate
            }

            it("sends current annotations to the delegate") {
                expect(delegate.receivedAnnotations).to(haveCount(1))
            }

        }

        context("when notified of data source changes") {

            beforeEach {
                subject.delegate = delegate

                expect(delegate.receivedAnnotations).to(haveCount(1))

                let newScooter = Scooter(latitude: 20.0, longitude: 10.0,
                                         energyLevel: 60, licensePlate: "xyz321")

                try! self.realm.write {
                    self.realm.add(newScooter)
                }

                dataSource.simulateChangeNotificationFromRealm()
            }

            it("sends new annotations to the delegate") {
                expect(delegate.receivedAnnotations).to(haveCount(2))
            }
        }

    }
}

// Realm notifications are async, so not safe for tests.
// Take control by injecting this dependency which we control
private class SpecDataSource: MapAnnotationDataSourcing {

    weak var delegate: MapAnnotationProvider?
    private(set) var results: Results<Scooter>

    init(results: Results<Scooter>) {
        self.results = results
    }

    func simulateChangeNotificationFromRealm() {
        delegate?.dataUpdated()
    }

}

private class SpecDelegate: MapAnnotationReceiving {

    var receivedAnnotations: [MKAnnotation]?

    func newAnnotations(_ annotations: [MKAnnotation]) {
        receivedAnnotations = annotations
    }
    
}
