import UIKit
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
    var mapAnnotations: [MKAnnotation] { get }
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState! { get }
    var shownAlert: MapViewModel.Alert? { get }

}

private class SpecMapView : SpecMapViewInterating {

    var showCurrentLocation: Bool?
    var userTrackingMode: MKUserTrackingMode?
    var mapRegion: MKCoordinateRegion?
    var mapOverlays = [MKOverlay]()
    var mapAnnotations = [MKAnnotation]()
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState!
    var shownAlert: MapViewModel.Alert?

    private let viewModel: MapViewModel
    private let mkMapView = SpecMKMapView()

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        // the following could be moved/removed if RxSwift
        // were used. Some other way without it?
        viewModel.delegate = self
        viewModel.viewDidLoad(mapViewDelegateHaving: mkMapView)
    }

    func tapCurrentLocationButton() {
        viewModel.tapCurrentLocationButton()
    }

    func drag() {
        mkMapView.drag()
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

    var mapView: SpecMapViewInterating!

    func createAndAttachToWindow(window _: UIWindow, viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
    }
    
}
