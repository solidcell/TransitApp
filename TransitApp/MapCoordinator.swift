import UIKit
import RealmSwift
import MapKit

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let mapSourceManager = MapSourceManager()
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm,
                                                          mapSourceManager: mapSourceManager)
        let annotations = mapAnnotationProvider.annotations
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: annotations)
        let mapViewDelegate = MapViewDelegate()
        let segmentedControlSource = SegmentedControlSource(mapSourceManager: mapSourceManager)
        let viewController = MapViewController.createFromStoryboard(annotations: annotations,
                                                                    initialCoordinateRegion: region,
                                                                    mapViewDelegate: mapViewDelegate,
                                                                    segmentedControlSource: segmentedControlSource)
        window.rootViewController = viewController
    }

}
