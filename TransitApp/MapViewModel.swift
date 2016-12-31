import CoreLocation
import MapKit

class MapViewModel {
    
    private let currentLocationViewModel: CurrentLocationViewModel
    private let initialCoordinateRegion: MKCoordinateRegion
    private let mapOverlayProvider: MapOverlayProvider
    private let mapAnnotationProvider: MapAnnotationProvider
    private let scooterUpdater: ScooterUpdater
    weak var delegate: MapViewModelDelegate!

    init(currentLocationViewModel: CurrentLocationViewModel,
         initialCoordinateRegion: MKCoordinateRegion,
         mapOverlayProvider: MapOverlayProvider,
         mapAnnotationProvider: MapAnnotationProvider,
         scooterUpdater: ScooterUpdater) {
        self.currentLocationViewModel = currentLocationViewModel
        self.initialCoordinateRegion = initialCoordinateRegion
        self.mapOverlayProvider = mapOverlayProvider
        self.mapAnnotationProvider = mapAnnotationProvider
        self.scooterUpdater = scooterUpdater
    }

    func viewDidLoad() {
        mapAnnotationProvider.delegate = self
        currentLocationViewModel.delegate = self
        delegate.setOverlays(mapOverlayProvider.overlays)
        delegate.setRegion(initialCoordinateRegion)
    }

    func tapCurrentLocationButton() {
        currentLocationViewModel.tapCurrentLocationButton()
    }

    struct Alert {
        let title: String
        let message: String?
        let actions: [Action]

        struct Action {
            let title: String?
            let style: UIAlertActionStyle
            let handler: Handler

            enum Handler {
                case noop
                case url(URL)
            }
        }
    }
    
}

extension MapViewModel : CurrentLocationViewModelDelegate {

    func setUserTracking(mode: MKUserTrackingMode) {
        delegate.setUserTracking(mode: mode)
    }

    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        delegate.setCurrentLocationButtonState(state)
    }

    func showAlert(_ alert: MapViewModel.Alert) {
        delegate.showAlert(alert)
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

protocol MapViewModelDelegate : class {

    func setUserTracking(mode: MKUserTrackingMode)
    func setRegion(_ region: MKCoordinateRegion)
    func setOverlays(_ overlays: [MKOverlay])
    func newAnnotations(_ annotations: [MKAnnotation])
    func annotationsReadyForUpdate(update: @escaping () -> Void)
    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState)
    func showAlert(_ alert: MapViewModel.Alert)
    
}
