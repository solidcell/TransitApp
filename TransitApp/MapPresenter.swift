import CoreLocation
import MapKit

class MapPresenter {
    
    private let initialCoordinateRegion: MKCoordinateRegion
    private let mapOverlayProvider: MapOverlayProvider
    private let mapAnnotationProvider: MapAnnotationProvider
    weak var viewController: MapViewControlling?

    init(initialCoordinateRegion: MKCoordinateRegion,
         mapOverlayProvider: MapOverlayProvider,
         mapAnnotationProvider: MapAnnotationProvider) {
        self.initialCoordinateRegion = initialCoordinateRegion
        self.mapOverlayProvider = mapOverlayProvider
        self.mapAnnotationProvider = mapAnnotationProvider
        mapAnnotationProvider.delegate = self
    }

    func viewDidLoad() {
        viewController?.setOverlays(mapOverlayProvider.overlays)
        viewController?.setRegion(initialCoordinateRegion)
        mapAnnotationProvider.start()
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

extension MapPresenter: CurrentLocationViewModelDelegate {

    func setShowCurrentLocation(_ enabled: Bool) {
        viewController?.setShowCurrentLocation(enabled)
    }

    func setUserTracking(mode: MKUserTrackingMode) {
        viewController?.setUserTracking(mode: mode)
    }

    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        viewController?.setCurrentLocationButtonState(state)
    }

    func showAlert(_ alert: MapPresenter.Alert) {
        viewController?.showAlert(alert)
    }
}

protocol MapAnnotationReceiving: class {

    func set(annotations: [MKAnnotation])
}

extension MapPresenter : MapAnnotationReceiving {

    func set(annotations: [MKAnnotation]) {
        viewController?.add(annotations: annotations)
    }
}
