import UIKit
import RealmSwift
import MapKit

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let stops = realm.stops
        let mapAnnotationCreator = MapAnnotationCreator()
        let annotations = mapAnnotationCreator.annotations(stops: stops)
        let coordinateRegion = initialCoordinateRegion(annotations: annotations)
        let viewController = MapViewController.createFromStoryboard(annotations: annotations,
                                                                    initialCoordinateRegion: coordinateRegion)
        window.rootViewController = viewController
    }

    private let fallbackInitialCoordinate = CLLocationCoordinate2D(latitude: 52.5302356, longitude: 13.4033659)
    
    private func initialCoordinateRegion(annotations: [MapAnnotation]) -> MKCoordinateRegion {
        let coordinate = annotations.first?.coordinate ?? self.fallbackInitialCoordinate
        let regionRadius: CLLocationDistance = 10000
        return MKCoordinateRegionMakeWithDistance(coordinate,
                                                  regionRadius * 2.0, regionRadius * 2.0)
    }

}
