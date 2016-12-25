import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapAnnotationProvider: MapAnnotationProvider!
    var mapOverlayProvider: MapOverlayProvider!
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
        configureMapOverlays()
        configureCurrentLocation()
    }

    private func configureMapOverlays() {
        mapOverlayProvider.overlays.forEach(mapView.add)
    }

    private func configureCurrentLocation() {
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
                                    mapOverlayProvider: MapOverlayProvider,
                                    mapViewDelegate: MKMapViewDelegate,
                                    scooterUpdater: ScooterUpdater,
                                    currentLocationProvider: CurrentLocationProvider,
                                    viewModel: MapViewModel) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.mapAnnotationProvider = mapAnnotationProvider
        vc.mapOverlayProvider = mapOverlayProvider
        vc.mapViewDelegate = mapViewDelegate
        vc.scooterUpdater = scooterUpdater
        vc.viewModel = viewModel
        return vc
    }
    
}
