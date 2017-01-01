import Quick
import Nimble
import MapKit
import FakeLocationManager
@testable import TransitApp

class MapViewDelegateSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: MapViewDelegate!
        var mapView: MKMapView!

        beforeEach {
            let locationManager = FakeLocationManager()
            let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
            let currentLocationViewModel = CurrentLocationViewModel(provider: currentLocationProvider)
            subject = MapViewDelegate(userTrackingModeDelegate: currentLocationViewModel)
            mapView = MKMapView()
        }

        describe("mapView(_:viewFor:)") {

            var coupMapAnnotation: CoupMapAnnotation!

            it("has a callout enabled") {
                let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: 0, licensePlate: "")
                coupMapAnnotation = CoupMapAnnotation(scooter: scooter)

                let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
                let pinAnnotationView = results as! MKPinAnnotationView
                expect(pinAnnotationView.canShowCallout).to(beTrue())
            }

            context("with energy level 51-100") {
                let energyLevel = 51

                beforeEach {
                    let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
                    coupMapAnnotation = CoupMapAnnotation(scooter: scooter)
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
                    let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
                    coupMapAnnotation = CoupMapAnnotation(scooter: scooter)
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
                    let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
                    coupMapAnnotation = CoupMapAnnotation(scooter: scooter)
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
