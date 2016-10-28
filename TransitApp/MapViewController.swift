import UIKit
import MapKit

class MapViewController: UIViewController {

    var annotations: [MapAnnotation]!

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        annotations.forEach(mapView.addAnnotation)
        
        let initialLocation = CLLocation(latitude: 52.5302356, longitude: 13.4033659)
        centerMapOnLocation(location: initialLocation)
    }

    private let regionRadius: CLLocationDistance = 10000
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

// MARK: Creation
extension MapViewController {
    
    class var storyboardName: String { return "MapViewController" }

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(annotations: [MapAnnotation]) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.annotations = annotations
        return vc
    }
    
}

