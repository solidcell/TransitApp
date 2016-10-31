import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapAnnotationProvider: MapAnnotationProvider!
    var mapOverlayProvider: MapOverlayProvider!
    var initialCoordinateRegion: MKCoordinateRegion!
    var mapViewDelegate: MKMapViewDelegate!

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = mapViewDelegate
        mapView.setRegion(initialCoordinateRegion, animated: true)
        configureMapAnnotations()
        configureMapOverlays()
    }

    private func configureMapOverlays() {
        mapOverlayProvider.overlays.forEach(mapView.add)
    }

    private func configureMapAnnotations() {
        mapAnnotationProvider.annotations.forEach(mapView.addAnnotation)
    }
}

// MARK: Creation
extension MapViewController {
    
    private static var storyboardName = "MapViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(mapAnnotationProvider: MapAnnotationProvider,
                                    mapOverlayProvider: MapOverlayProvider,
                                    initialCoordinateRegion: MKCoordinateRegion,
                                    mapViewDelegate: MKMapViewDelegate) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.mapAnnotationProvider = mapAnnotationProvider
        vc.mapOverlayProvider = mapOverlayProvider
        vc.initialCoordinateRegion = initialCoordinateRegion
        vc.mapViewDelegate = mapViewDelegate
        return vc
    }
    
}
