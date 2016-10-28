import UIKit
import RealmSwift

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let stops = realm.stops
        let mapAnnotationCreator = MapAnnotationCreator()
        let annotations = mapAnnotationCreator.annotations(stops: stops)
        let viewController = MapViewController.createFromStoryboard(annotations: annotations)
        window.rootViewController = viewController
    }

}
