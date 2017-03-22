import UIKit
import MapKit

protocol MapViewControllerFactoryProtocol {

    func create() -> MapViewController
}

class MapViewControllerFactory: MapViewControllerFactoryProtocol {
    
    private let storyboardName = "MapViewController"
    
    func create() -> MapViewController {
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
    }
}
