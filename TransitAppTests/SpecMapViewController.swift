import UIKit
import SpecUIKitFringes
import MapKit
@testable import TransitApp

protocol SpecMapViewInterating {
    
    // MARK: Input

    func tapCurrentLocationButton()
    func drag()

    // MARK: Output

    var showCurrentLocation: Bool { get }
    var userTrackingMode: MKUserTrackingMode! { get }
    var mapRegion: MKCoordinateRegion? { get }
    var mapOverlays: [MKOverlay] { get }
    var businessAreaOverlays: [MKPolygon] { get }
    var mapAnnotations: [MKAnnotation] { get }
    var scooterAnnotations: [CoupMapAnnotation] { get }
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState! { get }
    func scooterAnnotationView(for: MKAnnotation) -> CoupMapAnnotationView?
    func polygonRenderer(for overlay: MKOverlay) -> MKPolygonRenderer?
}

class SpecMapViewController: MapViewController, SpecMapViewInterating {

    private(set) var userTrackingMode: MKUserTrackingMode!
    private(set) var mapRegion: MKCoordinateRegion?
    private(set) var currentLocationButtonState: CurrentLocationViewModel.ButtonState!

    var mapOverlays: [MKOverlay] {
        return mapView.overlays
    }
    
    var mapAnnotations: [MKAnnotation] {
        return mapView.annotations
    }

    var showCurrentLocation: Bool {
        return mapView.showsUserLocation
    }

    private let specMapView = SpecMKMapView()
    override var mapView: MKMapView! {
        get { return specMapView }
        set { fatalError() }
    }

    func scooterAnnotationView(for annotation: MKAnnotation) -> CoupMapAnnotationView? {
        return mapView.delegate?.mapView?(mapView, viewFor: annotation) as? CoupMapAnnotationView
    }
    
    func polygonRenderer(for overlay: MKOverlay) -> MKPolygonRenderer? {
        return mapView.delegate?.mapView?(mapView, rendererFor: overlay) as? MKPolygonRenderer
    }

    func drag() {
        specMapView.drag()
    }
    
    var scooterAnnotations: [CoupMapAnnotation] {
        return mapAnnotations.flatMap { $0 as? CoupMapAnnotation }
    }
    
    var businessAreaOverlays: [MKPolygon] {
        return mapOverlays.flatMap { $0 as? MKPolygon }
    }

    override func setUserTracking(mode: MKUserTrackingMode) {
        userTrackingMode = mode
    }

    override func setRegion(_ region: MKCoordinateRegion) {
        mapRegion = region
    }

    override func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        currentLocationButtonState = state
    }
}

class SpecMapViewFactory: MapViewControllerFactoryProtocol {

    func create() -> MapViewController {
        return SpecMapViewController()
    }
}
