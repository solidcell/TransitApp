import CoreLocation
import MapKit

class MapViewModel {
    
    private let currentLocationProvider: CurrentLocationProvider
    private let initialCoordinateRegion: MKCoordinateRegion
    private let mapOverlayProvider: MapOverlayProvider
    private let mapAnnotationProvider: MapAnnotationProvider
    private let scooterUpdater: ScooterUpdater
    fileprivate var currentLocationButtonState = CurrentLocationButtonState.nonHighlighted
    weak var delegate: MapViewModelDelegate!

    init(currentLocationProvider: CurrentLocationProvider,
         initialCoordinateRegion: MKCoordinateRegion,
         mapOverlayProvider: MapOverlayProvider,
         mapAnnotationProvider: MapAnnotationProvider,
         scooterUpdater: ScooterUpdater) {
        self.currentLocationProvider = currentLocationProvider
        self.initialCoordinateRegion = initialCoordinateRegion
        self.mapOverlayProvider = mapOverlayProvider
        self.mapAnnotationProvider = mapAnnotationProvider
        self.scooterUpdater = scooterUpdater
    }

    func viewDidLoad() {
        currentLocationProvider.delegate = self
        mapAnnotationProvider.delegate = self
        delegate.setOverlays(mapOverlayProvider.overlays)
        delegate.setRegion(initialCoordinateRegion)
        notifyDelegateOfCurrentLocationButtonState()
    }

    func tapCurrentLocationButton() {
        toggleCurrentLocationButtonStates()
        currentLocationProvider.getCurrentLocation()
    }

    private func notifyDelegateOfCurrentLocationButtonState() {
        delegate.setCurrentLocationButtonState(currentLocationButtonState)
    }

    private func toggleCurrentLocationButtonStates() {
        switch currentLocationButtonState {
        case .nonHighlighted:
            currentLocationButtonState = .highlighted
        case .highlighted:
            currentLocationButtonState = .nonHighlighted
        }
        notifyDelegateOfCurrentLocationButtonState()
    }
    
}

extension MapViewModel {

    enum CurrentLocationButtonState {
        case nonHighlighted
        case highlighted
    }
    
}

extension MapViewModel : MapAnnotationReceiving {

    func newAnnotations(_ annotations: [MKAnnotation]) {
        delegate.newAnnotations(annotations)
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        delegate.annotationsReadyForUpdate(update: update)
    }

}

extension MapViewModel : CurrentLocationProviderDelegate {

    func currentLocation(_ location: CLLocation) {
        if currentLocationButtonState == .highlighted {
            delegate.centerMap(on: location.coordinate)
        }
    }
    
}

protocol MapViewModelDelegate : class {

    func centerMap(on: CLLocationCoordinate2D)
    func setRegion(_ region: MKCoordinateRegion)
    func setOverlays(_ overlays: [MKOverlay])
    func newAnnotations(_ annotations: [MKAnnotation])
    func annotationsReadyForUpdate(update: @escaping () -> Void)
    func setCurrentLocationButtonState(_ state: MapViewModel.CurrentLocationButtonState)
    
}
