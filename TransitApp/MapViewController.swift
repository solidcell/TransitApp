import UIKit
import MapKit

class MapViewController: UIViewController {

    var viewModel: MapViewModel!
    private let mapViewDelegate = MapViewDelegate()

    @IBOutlet weak var mapView: MKMapView!

    @IBAction func currentLocationTap(_ sender: AnyObject) {
        viewModel.tapCurrentLocationButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidLoad()
        mapView.delegate = mapViewDelegate
        mapView.showsUserLocation = true
    }

}

extension MapViewController: MapViewModelDelegate {

    func centerMap(on coordinate: CLLocationCoordinate2D) {
        mapView.setCenter(coordinate, animated: true)
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
}
