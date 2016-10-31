import UIKit
import RealmSwift
import MapKit

class MapSelectorCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let mapSourceManager = MapSourceManager(realm: realm)
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm,
                                                          mapSourceManager: mapSourceManager)
        let mapOverlayProvider = MapOverlayProvider(realm: realm,
                                                    mapSourceManager: mapSourceManager)
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: mapAnnotationProvider.annotations)
        let mapViewDelegate = MapViewDelegate()
        let segmentedControlSource = SegmentedControlSource(mapSourceManager: mapSourceManager)
        let viewController = MapSelectorViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                                            mapOverlayProvider: mapOverlayProvider,
                                                                            initialCoordinateRegion: region,
                                                                            mapViewDelegate: mapViewDelegate,
                                                                            segmentedControlSource: segmentedControlSource)
        window.rootViewController = viewController
    }

}
