import Quick
import Nimble
import MapKit
@testable import TransitApp

class MapViewDelegateSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        let subject = MapViewDelegate()
        var coordinate: CLLocationCoordinate2D!
        var mapView: MKMapView!

        beforeEach {
            coordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)
            mapView = MKMapView()
        }

        describe("mapView(_:,viewFor:)") {
            
            context("when the annotation is a Door2DoorMapAnnotation") {
                var door2DoorMapAnnotation: Door2DoorMapAnnotation!

                beforeEach {
                    door2DoorMapAnnotation = Door2DoorMapAnnotation(title: nil,
                                                                    locationName: nil,
                                                                    discipline: nil,
                                                                    coordinate: coordinate)
                }
                
                it("returns nil") {
                    let results = subject.mapView(mapView, viewFor: door2DoorMapAnnotation)
                    expect(results).to(beNil())
                }
            }
            
            context("when the annotation is a CoupMapAnnotation") {
                var coupMapAnnotation: CoupMapAnnotation!

                beforeEach {
                    coupMapAnnotation = CoupMapAnnotation(title: "",
                                                          coordinate: coordinate,
                                                          energyLevel: 55)
                }
                
                it("returns nil") {
                    let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                    expect(results).to(beNil())
                }
            }
            
        }
    }
}
