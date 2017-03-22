import UIKit
import SpecUIKitFringes
import MapKit
@testable import TransitApp

protocol SpecMapViewInterating {
    
    // MARK: Input

    func tapCurrentLocationButton()
    func drag()

    // MARK: Output

    var showCurrentLocation: Bool! { get }
    var userTrackingMode: MKUserTrackingMode! { get }
    var mapRegion: MKCoordinateRegion? { get }
    var mapOverlays: [MKOverlay] { get }
    var businessAreaOverlays: [MKPolygon] { get }
    var mapAnnotations: [MKAnnotation] { get }
    var scooterAnnotations: [CoupMapAnnotation] { get }
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState! { get }
    var shownAlert: MapPresenter.Alert! { get }
    func scooterAnnotationView(for: MKAnnotation) -> CoupMapAnnotationView?
    func polygonRenderer(for overlay: MKOverlay) -> MKPolygonRenderer?
}

class SpecMapViewController: MapViewController, SpecMapViewInterating {

    private(set) var showCurrentLocation: Bool!
    private(set) var userTrackingMode: MKUserTrackingMode!
    private(set) var mapRegion: MKCoordinateRegion?
    private(set) var mapOverlays = [MKOverlay]()
    private(set) var mapAnnotations = [MKAnnotation]()
    private(set) var currentLocationButtonState: CurrentLocationViewModel.ButtonState!
    private(set) var shownAlert: MapPresenter.Alert!

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

    override func setShowCurrentLocation(_ enabled: Bool) {
        showCurrentLocation = enabled
    }

    override func setUserTracking(mode: MKUserTrackingMode) {
        userTrackingMode = mode
    }

    override func setRegion(_ region: MKCoordinateRegion) {
        mapRegion = region
    }

    override func setOverlays(_ overlays: [MKOverlay]) {
        mapOverlays = overlays
    }
    
    override func add(annotations: [MKAnnotation]) {
        mapAnnotations = annotations
    }

    override func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        currentLocationButtonState = state
    }
    
    override func showAlert(_ alert: MapPresenter.Alert) {
        shownAlert = alert
    }
}

class SpecMapViewFactory: MapViewControllerFactoryProtocol {

    func create() -> MapViewController {
        return SpecMapViewController()
    }
}
