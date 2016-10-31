import UIKit
import RealmSwift

class MapCoordinator {

    func start(realm: Realm) -> UIViewController {
        let mapSourceManager = MapSourceManager(realm: realm)
        let source = mapSourceManager.source
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm, source: source)
        let mapOverlayProvider = MapOverlayProvider(realm: realm, source: source)
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: mapAnnotationProvider.annotations)
        let mapViewDelegate = MapViewDelegate()
        return MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                      mapOverlayProvider: mapOverlayProvider,
                                                      initialCoordinateRegion: region,
                                                      mapViewDelegate: mapViewDelegate)
    }

}
