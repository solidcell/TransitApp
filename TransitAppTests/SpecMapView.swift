import UIKit
import MapKit
@testable import TransitApp

protocol SpecMapViewInterating {
    
    // MARK: Input

    func tapCurrentLocationButton()

    // MARK: Output

    var mapCenteredOn: CLLocationCoordinate2D? { get }
    var mapRegion: MKCoordinateRegion? { get }
    var mapOverlays: [MKOverlay] { get }
    var mapAnnotations: [MKAnnotation] { get }
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState! { get }
    
}

private class SpecMapView : SpecMapViewInterating {

    var mapCenteredOn: CLLocationCoordinate2D?
    var mapRegion: MKCoordinateRegion?
    var mapOverlays = [MKOverlay]()
    var mapAnnotations = [MKAnnotation]()
    var currentLocationButtonState: CurrentLocationViewModel.ButtonState!

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

    func centerMap(on coordinate: CLLocationCoordinate2D) {
        self.mapCenteredOn = coordinate
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

}

class SpecMapViewFactory : MapViewFactory {

    var mapView: SpecMapViewInterating!

    func createAndAttachToWindow(window _: UIWindow, viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
    }
    
}
