import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 52.5302356, longitude: 13.4033659)
        centerMapOnLocation(location: initialLocation)

        let mapAnnotation = MapAnnotation(title: "title - Berlin",
                                    locationName: "location name - Berlin",
                                    discipline: "discipline - Berlin",
                                    coordinate: CLLocationCoordinate2D(latitude: 52.5302356,
                                                                       longitude: 13.4033659))
        
        mapView.addAnnotation(mapAnnotation)
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
    class func createFromStoryboard() -> MapViewController {
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
    }
    
}

