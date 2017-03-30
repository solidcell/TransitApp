import UIKit
import UIKitFringes
import MapKit

class MapViewController: UIViewController {

    var interactor: MapInteractor!
    var dispatchHandler: DispatchHandling!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet private weak var currentLocationButton: UIButton!
    
    @IBAction func tapCurrentLocationButton() {
        interactor.tapCurrentLocationButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.viewDidLoad(mapViewDelegateHaving: mapView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        RoundButtonStyler.style(button: currentLocationButton)
    }

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
        dispatchHandler.async(on: .main) {
            self.mapView.addOverlays(overlays)
        }
    }
    
    func add(annotations: [MKAnnotation]) {
        dispatchHandler.async(on: .main) {
            self.mapView.addAnnotations(annotations)
        }
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
}
