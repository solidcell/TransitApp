import UIKit
import MapKit

protocol MapViewFactory {

    func create() -> MapViewControlling
}

class MapViewControllerFactory: MapViewFactory {
    
    private let storyboardName = "MapViewController"
    
    func create() -> MapViewControlling {
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
    }
}
