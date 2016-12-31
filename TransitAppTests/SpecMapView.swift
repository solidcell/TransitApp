import UIKit
import MapKit
@testable import TransitApp

protocol SpecMapViewInterating {
    
    // MARK: Input

    func tapCurrentLocationButton()

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

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        // the following could be moved/removed if RxSwift
        // were used. Some other way without it?
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    func tapCurrentLocationButton() {
        viewModel.tapCurrentLocationButton()
    }
    
}

extension SpecMapView : MapViewModelDelegate {

    func setShowCurrentLocation(_ enabled: Bool) {
        self.showCurrentLocation = enabled
    }

    func setUserTracking(mode: MKUserTrackingMode) {
        self.userTrackingMode = mode
    }

    func setRegion(_ region: MKCoordinateRegion) {
        self.mapRegion = region
    }

    func setOverlays(_ overlays: [MKOverlay]) {
        self.mapOverlays = overlays
    }
    
    func newAnnotations(_ annotations: [MKAnnotation]) {
        self.mapAnnotations.append(contentsOf: annotations)
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        update()
    }

    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        self.currentLocationButtonState = state
    }
    
    func showAlert(_ alert: MapViewModel.Alert) {
        self.shownAlert = alert
    }

}

class SpecMapViewFactory : MapViewFactory {

    var mapView: SpecMapViewInterating!

    func createAndAttachToWindow(window _: UIWindow, viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
    }
    
}
