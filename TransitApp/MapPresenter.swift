import UIKitFringes
import CoreLocation
import MapKit

class MapPresenter {
    
    private let initialCoordinateRegion: MKCoordinateRegion
    private let mapOverlayProvider: MapOverlayProvider
    private let mapAnnotationProvider: MapAnnotationProvider
    fileprivate let sharedApplication: ApplicationProtocol
    weak var viewController: MapViewController?

    init(initialCoordinateRegion: MKCoordinateRegion,
         mapOverlayProvider: MapOverlayProvider,
         mapAnnotationProvider: MapAnnotationProvider,
         sharedApplication: ApplicationProtocol) {
        self.initialCoordinateRegion = initialCoordinateRegion
        self.mapOverlayProvider = mapOverlayProvider
        self.mapAnnotationProvider = mapAnnotationProvider
        self.sharedApplication = sharedApplication
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
                case custom(() -> Void)
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
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        alert.actions.forEach { action in
            let handler: ((UIAlertAction) -> Void)?
            switch action.handler {
            case .noop:
                handler = nil
            case .custom(let block):
                handler = { _ in block() }
            case .url(let url):
                handler = { _ in _ = self.sharedApplication.openURL(url) }
            }
            let action = UIAlertAction(title: action.title,
                                       style: action.style,
                                       handler: handler)
            alertController.addAction(action)
        }
        viewController?.present(alertController, animated: true, completion: nil)
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
