import Quick
import Nimble
import MapKit
@testable import TransitApp

class MapViewDelegateSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapViewDelegate!
        var coordinate: CLLocationCoordinate2D!
        var mapView: MKMapView!

        beforeEach {
            subject = MapViewDelegate()
            coordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 2.0)
            mapView = MKMapView()
        }

        describe("mapView(_:viewFor:)") {

            var coupMapAnnotation: CoupMapAnnotation!

            it("has a callout enabled") {
                coupMapAnnotation = CoupMapAnnotation(title: "",
                                                      coordinate: coordinate,
                                                      energyLevel: 0)

                let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                let pinAnnotationView = results as! MKPinAnnotationView
                expect(pinAnnotationView.canShowCallout).to(beTrue())
            }

            context("with energy level 51-100") {
                let energyLevel = 51

                beforeEach {
                    coupMapAnnotation = CoupMapAnnotation(title: "",
                                                          coordinate: coordinate,
                                                          energyLevel: energyLevel)
                }

                it("returns an MKPinAnnotationView with a green tint") {
                    let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                    let pinAnnotationView = results as! MKPinAnnotationView
                    expect(pinAnnotationView.pinTintColor).to(equal(UIColor.green))
                }
            }

            context("with energy level 31-50") {
                let energyLevel = 31

                beforeEach {
                    coupMapAnnotation = CoupMapAnnotation(title: "",
                                                          coordinate: coordinate,
                                                          energyLevel: energyLevel)
                }

                it("returns an MKPinAnnotationView with a yellow tint") {
                    let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                    let pinAnnotationView = results as! MKPinAnnotationView
                    expect(pinAnnotationView.pinTintColor).to(equal(UIColor.yellow))
                }
            }

            context("with energy level 0-30") {
                let energyLevel = 30

                beforeEach {
                    coupMapAnnotation = CoupMapAnnotation(title: "",
                                                          coordinate: coordinate,
                                                          energyLevel: energyLevel)
                }

                it("returns an MKPinAnnotationView with a red tint") {
                    let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                    let pinAnnotationView = results as! MKPinAnnotationView
                    expect(pinAnnotationView.pinTintColor).to(equal(UIColor.red))
                }
            }

        }

        describe("mapView(_:rendererFor:)") {
            it("returns an MKPolygonRenderer") {
                let overlay = MKPolygon(coordinates: [], count: 0)
                let result = subject.mapView(mapView, rendererFor: overlay)
                expect(result).to(beAnInstanceOf(MKPolygonRenderer.self))
            }
        }
    }
}
