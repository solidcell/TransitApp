import Quick
import Nimble
import MapKit
import SpecUIKitFringes
@testable import TransitApp

class MapViewDelegateSpec: TransitAppSpec {

    var subject: MapViewDelegate!
    var mapView: MKMapView!

    override func setUp() {
        super.setUp()

        let dialogManager = SpecDialogManager()
        let locationServices = SpecLocationServices()
        let userLocation = SpecUserLocation()
        let locationAuthorizationStatus = SpecLocationAuthorizationStatus()
        let locationManager = SpecLocationManager(dialogManager: dialogManager,
                                                  userLocation: userLocation,
                                                  locationServices: locationServices,
                                                  locationAuthorizationStatus: locationAuthorizationStatus)
        let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
        let currentLocationViewModel = CurrentLocationViewModel(provider: currentLocationProvider)
        subject = MapViewDelegate(userTrackingModeDelegate: currentLocationViewModel)
        mapView = MKMapView()
    }

    func testMapViewViewForHasACalloutEnabled() {
        let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: 0, licensePlate: "")
        let coupMapAnnotation = CoupMapAnnotation(scooter: scooter)

        let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
        let pinAnnotationView = results as! MKPinAnnotationView
        XCTAssertTrue(pinAnnotationView.canShowCallout)
    }

    func testMapViewViewForWithEnergyLevelAbove50() {
        let energyLevel = 51

        let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
        let coupMapAnnotation = CoupMapAnnotation(scooter: scooter)

        let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
        let pinAnnotationView = results as! MKPinAnnotationView
        XCTAssertEqual(pinAnnotationView.pinTintColor, UIColor.green)
    }

    func testMapViewViewForWithEnergyLevelBetween31and50() {
        let energyLevel = 31

        let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
        let coupMapAnnotation = CoupMapAnnotation(scooter: scooter)

        let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
        let pinAnnotationView = results as! MKPinAnnotationView
        XCTAssertEqual(pinAnnotationView.pinTintColor, UIColor.yellow)
    }

    func testMapViewViewWithEnergyLevelBelow31() {
        let energyLevel = 30

        let scooter = Scooter(latitude: 1.0, longitude: 2.0, energyLevel: energyLevel, licensePlate: "")
        let coupMapAnnotation = CoupMapAnnotation(scooter: scooter)

        let results = subject.mapView(mapView, viewFor: coupMapAnnotation)
        let pinAnnotationView = results as! MKPinAnnotationView
        XCTAssertEqual(pinAnnotationView.pinTintColor, UIColor.red)
    }

    func testMapViewRendererFor() {
        let overlay = MKPolygon(coordinates: [], count: 0)
        let result = subject.mapView(mapView, rendererFor: overlay)
        XCTAssertNotNil(result as? MKPolygonRenderer)
    }
}
