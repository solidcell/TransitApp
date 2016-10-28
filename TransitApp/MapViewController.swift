import UIKit
import MapKit

class MapViewController: UIViewController {

    var annotations: [MapAnnotation]!
    var initialCoordinateRegion: MKCoordinateRegion!
    var mapViewDelegate: MKMapViewDelegate!

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = mapViewDelegate
        annotations.forEach(mapView.addAnnotation)
        mapView.setRegion(initialCoordinateRegion, animated: true)
    }
    
}

// MARK: Creation
extension MapViewController {
    
    class var storyboardName: String { return "MapViewController" }

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(annotations: [MapAnnotation],
                                    initialCoordinateRegion: MKCoordinateRegion,
                                    mapViewDelegate: MKMapViewDelegate) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.annotations = annotations
        vc.initialCoordinateRegion = initialCoordinateRegion
        vc.mapViewDelegate = mapViewDelegate
        return vc
    }
    
}

