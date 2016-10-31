import UIKit
import RealmSwift

class MapCoordinator {

    func start(realm: Realm) -> UIViewController {
        let mapSourceManager = MapSourceManager(realm: realm)
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm,
                                                          mapSourceManager: mapSourceManager)
        let mapOverlayProvider = MapOverlayProvider(realm: realm,
                                                    mapSourceManager: mapSourceManager)
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: mapAnnotationProvider.annotations)
        let mapViewDelegate = MapViewDelegate()
        return MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                      mapOverlayProvider: mapOverlayProvider,
                                                      initialCoordinateRegion: region,
                                                      mapViewDelegate: mapViewDelegate)
    }

}
