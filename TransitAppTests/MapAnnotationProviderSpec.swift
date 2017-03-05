import XCTest

import MapKit
@testable import TransitApp
/*
class MapAnnotationProviderSpec: XCTestCase {

    var subject: MapAnnotationProvider!
    var dataSource: MapAnnotationDataSource!
    var scooterRealmNotifier: SpecScooterRealmNotifier!
    private var delegate: SpecDelegate!
    var scooter: Scooter!

    override func setUp() {
        super.setUp()
        scooterRealmNotifier = SpecScooterRealmNotifier(realm: realm)
        dataSource = MapAnnotationDataSource(scooterRealmNotifier: scooterRealmNotifier)
        subject = MapAnnotationProvider(dataSource: dataSource)
        delegate = SpecDelegate()

        scooter = Scooter(latitude: 50.0, longitude: 60.0,
                          energyLevel: 70, licensePlate: "123abc")
        realm.addOrUpdate(scooters: [scooter])
    }

    func testWhenSettingTheDelegate() {
        XCTAssertEqual(delegate.annotations.count, 0)
        XCTAssertTrue(scooterRealmNotifier.callbackExecuted)
        subject.delegate = delegate
        XCTAssertEqual(delegate.annotations.count, 1)

    }

    func testWhenNotifiedOfDatasourceInitialDat() {
        XCTAssertEqual(delegate.annotations.count, 0)
        subject.delegate = delegate
        expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
        expect(delegate.annotations).to(haveCount(1))
    }

    func testWhenNotifiedOfDatasourceInsertions() {
        subject.delegate = delegate
        expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
        expect(delegate.annotations).to(haveCount(1))

        let newScooter = Scooter(latitude: -10.0, longitude: 55.0,
                                 energyLevel: 2, licensePlate: "xyz111")
        realm.addOrUpdate(scooters: [newScooter])
        expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
        expect(delegate.annotations).to(haveCount(2))
    }

    func testWhenNotifiedOfDatasourceUpdates() {
        subject.delegate = delegate
        expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
        expect(delegate.annotations).to(haveCount(1))
        let coordinateBefore = delegate.annotations.first!.coordinate
        expect(coordinateBefore).to(equal(CLLocationCoordinate2D(latitude: 50.0,
                                                                 longitude: 60.0)))
        let updatedScooter = Scooter(latitude: 51.0, longitude: 61.0,
                                     energyLevel: 68, licensePlate: "123abc")
        realm.addOrUpdate(scooters: [updatedScooter])
        expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())

        expect(delegate.annotations).to(haveCount(1))
        let coordinateAfter = delegate.annotations.first!.coordinate
        expect(coordinateAfter).to(equal(CLLocationCoordinate2D(latitude: 51.0,
                                                                longitude: 61.0)))
    }
}

private class SpecDelegate: MapAnnotationReceiving {

    var annotations = [MKAnnotation]()

    func newAnnotations(_ annotations: [MKAnnotation]) {
        annotations += annotations
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        update()
    }

}
 */
