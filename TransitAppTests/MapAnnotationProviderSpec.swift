import Quick
import Nimble
import RealmSwift
import MapKit
@testable import TransitApp

class MapAnnotationProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapAnnotationProvider!
        var dataSource: MapAnnotationDataSource!
        var scooterWriter: SpecScooterWriter!
        var delegate: SpecDelegate!
        var scooter: Scooter!

        beforeEach {
            scooterWriter = SpecScooterWriter(realm: self.realm)
            dataSource = MapAnnotationDataSource(scooterWriter: scooterWriter)
            subject = MapAnnotationProvider(dataSource: dataSource)
            delegate = SpecDelegate()

            scooter = Scooter(latitude: 50.0, longitude: 60.0,
                              energyLevel: 70, licensePlate: "123abc")
            scooterWriter.addOrUpdate(scooters: [scooter])
        }

        describe("when setting the delegate") {

            beforeEach {
                expect(delegate.annotations).to(beEmpty())
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
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
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
            }

            it("sends new annotations to the delegate") {
                expect(delegate.annotations).to(haveCount(1))
            }
        }

        context("when notified of datasource insertions") {

            beforeEach {
                subject.delegate = delegate
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
                scooterWriter.callbackExecuted = false
                expect(delegate.annotations).to(haveCount(1))

                let newScooter = Scooter(latitude: -10.0, longitude: 55.0,
                                  energyLevel: 2, licensePlate: "xyz111")
                scooterWriter.addOrUpdate(scooters: [newScooter])
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
            }

            it("sends new annotations to the delegate") {
                expect(delegate.annotations).to(haveCount(2))
            }
        }

        context("when notified of datasource updates") {

            beforeEach {
                subject.delegate = delegate
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
                scooterWriter.callbackExecuted = false
                expect(delegate.annotations).to(haveCount(1))
                let coordinateBefore = delegate.annotations.first!.coordinate
                expect(coordinateBefore).to(equal(CLLocationCoordinate2D(latitude: 50.0,
                                                                         longitude: 60.0)))
                let updatedScooter = Scooter(latitude: 51.0, longitude: 61.0,
                                             energyLevel: 68, licensePlate: "123abc")
                scooterWriter.addOrUpdate(scooters: [updatedScooter])
                expect(scooterWriter.callbackExecuted).toEventually(beTrue())
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

private class SpecDelegate: MapAnnotationReceiving {

    var annotations = [MKAnnotation]()

    func newAnnotations(_ annotations: [MKAnnotation]) {
        self.annotations += annotations
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        update()
    }

}

private class SpecScooterWriter: ScooterWriter {

    var callbackExecuted = false

    override func notificationCallback(changes: RealmCollectionChange<Results<Scooter>>) -> Void {
        super.notificationCallback(changes: changes)
        callbackExecuted = true
    }
}
