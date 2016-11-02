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
                expect(delegate.newAnnotations).to(beNil())
                subject.delegate = delegate
            }

            it("sends current annotations to the delegate") {
                expect(delegate.newAnnotations).to(beEmpty())
            }

        }

        context("when notified of datasource initial data") {

            beforeEach {
                dataSource.simulateRealmChange(initial: [scooter])
                subject.delegate = delegate
            }

            it("sends new annotations to the delegate") {
                expect(delegate.newAnnotations).to(haveCount(1))
            }
        }

        context("when notified of datasource insertions") {

            beforeEach {
                subject.delegate = delegate
                expect(delegate.newAnnotations).to(beEmpty())
                dataSource.simulateRealmChange(insertions: [scooter])
            }

            it("sends new annotations to the delegate") {
                expect(delegate.newAnnotations).to(haveCount(1))
            }
        }

    }
}

// Realm notifications are async, so not safe for tests.
// Take control by injecting this dependency which we control
private class SpecDataSource: MapAnnotationDataSourcing {

    weak var delegate: MapAnnotationProvider?

    func simulateRealmChange(initial: [Scooter]) {
        delegate?.initialData(scooters: initial)
    }

    func simulateRealmChange(insertions: [Scooter]) {
        delegate?.dataUpdated(deletions: [], insertions: insertions, modifications: [])
    }

}

private class SpecDelegate: MapAnnotationReceiving {

    var newAnnotations: [MKAnnotation]? {
        get {
            defer { _newAnnotations = nil }
            return _newAnnotations
        }
        set {
            _newAnnotations = newValue
        }
    }
    private var _newAnnotations: [MKAnnotation]?

    func newAnnotations(_ annotations: [MKAnnotation]) {
        newAnnotations = annotations
    }
    
}
