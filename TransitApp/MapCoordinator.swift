import UIKit
import RealmSwift
import MapKit

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm)
        let annotations = mapAnnotationProvider.annotations()
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: annotations)
        let mapViewDelegate = MapViewDelegate()
        let segmentedControlSource = SegmentedControlSource()
        let viewController = MapViewController.createFromStoryboard(annotations: annotations,
                                                                    initialCoordinateRegion: region,
                                                                    mapViewDelegate: mapViewDelegate,
                                                                    segmentedControlSource: segmentedControlSource)
        window.rootViewController = viewController
    }

}
