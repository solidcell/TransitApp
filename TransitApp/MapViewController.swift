import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapAnnotationProvider: MapAnnotationProvider!
    var mapViewDelegate: MKMapViewDelegate!
    var scooterUpdater: ScooterUpdater!
    var viewModel: MapViewModel!

    @IBOutlet weak var mapView: MKMapView!

    @IBAction func currentLocationTap(_ sender: AnyObject) {
        viewModel.tapCurrentLocationButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.viewDidLoad()
        mapView.delegate = mapViewDelegate
        mapAnnotationProvider.delegate = self
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
    
}

extension MapViewController: MapAnnotationReceiving {

    func newAnnotations(_ annotations: [MKAnnotation]) {
        annotations.forEach(mapView.addAnnotation)
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0) {
            update()
        }
    }
    
}

// MARK: Creation
extension MapViewController {
    
    private static var storyboardName = "MapViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(mapAnnotationProvider: MapAnnotationProvider,
                                    mapViewDelegate: MKMapViewDelegate,
                                    scooterUpdater: ScooterUpdater,
                                    viewModel: MapViewModel) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.mapAnnotationProvider = mapAnnotationProvider
        vc.mapViewDelegate = mapViewDelegate
        vc.scooterUpdater = scooterUpdater
        vc.viewModel = viewModel
        return vc
    }
    
}
