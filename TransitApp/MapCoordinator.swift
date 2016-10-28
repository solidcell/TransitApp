import UIKit
import RealmSwift
import MapKit

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let stops = realm.stops
        let mapAnnotationCreator = MapAnnotationCreator()
        let annotations = mapAnnotationCreator.annotations(stops: stops)
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: annotations)
        let mapViewDelegate = MapViewDelegate()
        let viewController = MapViewController.createFromStoryboard(annotations: annotations,
                                                                    initialCoordinateRegion: region,
                                                                    mapViewDelegate: mapViewDelegate)
        window.rootViewController = viewController
    }

}
