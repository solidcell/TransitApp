import UIKit
import SpecUIKitFringes
import MapKit
@testable import TransitApp

protocol SpecMapViewInterating {
    
    // MARK: Input

    func tapCurrentLocationButton()
    func drag()

    // MARK: Output

    var showCurrentLocation: Bool? { get }
    var userTrackingMode: MKUserTrackingMode? { get }
    var mapRegion: MKCoordinateRegion? { get }
    var mapOverlays: [MKOverlay] { get }
    var businessAreaOverlays: [MKPolygon] { get }
    var mapAnnotations: [MKAnnotation] { get }
    var scooterAnnotations: [CoupMapAnnotation] { get }
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState! { get }
    var shownAlert: MapViewModel.Alert? { get }

}

class SpecMapView: SpecViewController, MapViewControlling, SpecMapViewInterating {

    var showCurrentLocation: Bool?
    var userTrackingMode: MKUserTrackingMode?
    var mapRegion: MKCoordinateRegion?
    var mapOverlays = [MKOverlay]()
    var mapAnnotations = [MKAnnotation]()
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState!
    var shownAlert: MapViewModel.Alert?

    private let mkMapView = SpecMKMapView()

    var viewModel: MapViewModel!

    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.viewDidLoad(mapViewDelegateHaving: mkMapView)
    }

    func tapCurrentLocationButton() {
        viewModel.tapCurrentLocationButton()
    }

    func drag() {
        mkMapView.drag()
    }
    
    var scooterAnnotations: [CoupMapAnnotation] {
        return mapAnnotations.flatMap { $0 as? CoupMapAnnotation }
    }
    
    var businessAreaOverlays: [MKPolygon] {
        return mapOverlays.flatMap { $0 as? MKPolygon }
    }
}

extension SpecMapView : MapViewModelDelegate {

    func setShowCurrentLocation(_ enabled: Bool) {
        showCurrentLocation = enabled
    }

    func setUserTracking(mode: MKUserTrackingMode) {
        userTrackingMode = mode
    }

    func setRegion(_ region: MKCoordinateRegion) {
        mapRegion = region
    }

    func setOverlays(_ overlays: [MKOverlay]) {
        mapOverlays = overlays
    }
    
    func add(annotations: [MKAnnotation]) {
        mapAnnotations = annotations
    }

    func removeAllAnnotations() {
        mapAnnotations = []
    }

    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        currentLocationButtonState = state
    }
    
    func showAlert(_ alert: MapViewModel.Alert) {
        shownAlert = alert
    }

}

class SpecMapViewFactory : MapViewFactory {

    func create() -> MapViewControlling {
        return SpecMapView()
    }
}
