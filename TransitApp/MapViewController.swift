import UIKit
import MapKit

class MapViewController: UIViewController {

    var viewModel: MapViewModel!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    @IBAction func currentLocationTap(_ sender: AnyObject) {
        viewModel.tapCurrentLocationButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidLoad(mapViewDelegateHaving: mapView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        RoundButtonStyler.style(button: currentLocationButton)
    }

}

extension MapViewController: MapViewModelDelegate {

    func setShowCurrentLocation(_ enabled: Bool) {
        mapView.showsUserLocation = enabled
    }

    func setUserTracking(mode: MKUserTrackingMode) {
        mapView.setUserTrackingMode(mode, animated: true)
    }
    
    func setRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }

    func setOverlays(_ overlays: [MKOverlay]) {
        overlays.forEach(mapView.add)
    }
    
    func newAnnotations(_ annotations: [MKAnnotation]) {
        annotations.forEach(mapView.addAnnotation)
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0, animations: update)
    }

    func setCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState) {
        let image: UIImage
        switch state {
        case .highlighted:
            image = #imageLiteral(resourceName: "currentLocationArrowFilled")
        case .nonHighlighted:
            image = #imageLiteral(resourceName: "currentLocationArrowHollow")
        }
        currentLocationButton.setImage(image, for: .normal)
    }

    func showAlert(_ alert: MapViewModel.Alert) {
        let controller = UIAlertController(title: alert.title,
                                           message: alert.message,
                                           preferredStyle: .alert)
        alert.actions.forEach { action in
            let handler: ((UIAlertAction) -> Void)?
            switch action.handler {
            case .noop:
                handler = nil
            case .url(let url):
                handler = { _ in UIApplication.shared.openURL(url) }
            }
            let action = UIAlertAction(title: action.title,
                                       style: action.style,
                                       handler: handler)
            controller.addAction(action)
        }
        self.present(controller, animated: true, completion: nil)
    }
}
