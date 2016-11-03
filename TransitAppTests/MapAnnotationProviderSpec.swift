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
        var scooter: Scooter!

        beforeEach {
            scooter = Scooter(latitude: 50.0, longitude: 60.0,
                              energyLevel: 70, licensePlate: "123abc")

            dataSource = SpecDataSource()
            subject = MapAnnotationProvider(dataSource: dataSource)
            delegate = SpecDelegate()
        }

        describe("when setting the delegate") {

            beforeEach {
                expect(delegate.annotations).to(beEmpty())
                dataSource.simulateRealmChange(initial: [scooter])
                subject.delegate = delegate
            }

            it("sends current annotations to the delegate") {
                expect(delegate.annotations).to(haveCount(1))
            }

        }

        context("when notified of datasource initial data") {

            beforeEach {
                expect(delegate.annotations).to(beEmpty())
                subject.delegate = delegate
                dataSource.simulateRealmChange(initial: [scooter])
            }

            it("sends new annotations to the delegate") {
                expect(delegate.annotations).to(haveCount(1))
            }
        }

        context("when notified of datasource insertions") {

            beforeEach {
                subject.delegate = delegate
                expect(delegate.annotations).to(beEmpty())
                dataSource.simulateRealmChange(insertions: [scooter])
            }

            it("sends new annotations to the delegate") {
                expect(delegate.annotations).to(haveCount(1))
            }
        }

        context("when notified of datasource updates") {

            beforeEach {
                subject.delegate = delegate
                dataSource.simulateRealmChange(initial: [scooter])
                expect(delegate.annotations).to(haveCount(1))
                let coordinateBefore = delegate.annotations.first!.coordinate
                expect(coordinateBefore).to(equal(CLLocationCoordinate2D(latitude: 50.0,
                                                                         longitude: 60.0)))
                let updatedScooter = Scooter(latitude: 51.0, longitude: 61.0,
                                             energyLevel: 68, licensePlate: "123abc")
                dataSource.simulateRealmChange(updates: [updatedScooter])
            }

            it("notifies the delegate with a callback") {
                expect(delegate.annotations).to(haveCount(1))
                let coordinateAfter = delegate.annotations.first!.coordinate
                expect(coordinateAfter).to(equal(CLLocationCoordinate2D(latitude: 51.0,
                                                                        longitude: 61.0)))
            }
        }

    }
}

// Realm notifications are async, so not safe for tests.
// Take control by injecting this dependency which we control
private class SpecDataSource: MapAnnotationDataSourcing {

    weak var delegate: MapAnnotationProvider?

    func simulateRealmChange(initial: [Scooter]) {
        delegate!.initialData(scooters: initial)
    }

    func simulateRealmChange(insertions: [Scooter]) {
        delegate!.dataUpdated(deletions: [], insertions: insertions, modifications: [])
    }

    func simulateRealmChange(updates: [Scooter]) {
        delegate!.dataUpdated(deletions: [], insertions: [], modifications: updates)
    }

}

private class SpecDelegate: MapAnnotationReceiving {

    var annotations = [MKAnnotation]()

    func newAnnotations(_ annotations: [MKAnnotation]) {
        self.annotations += annotations
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        update()
    }

}
