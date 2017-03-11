import UIKit
import MapKit

protocol MapViewControllerFactoryProtocol {

    func create() -> MapViewControlling
}

class MapViewControllerFactory: MapViewControllerFactoryProtocol {
    
    private let storyboardName = "MapViewController"
    
    func create() -> MapViewControlling {
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
    }
}
