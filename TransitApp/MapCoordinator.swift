import UIKit
import RealmSwift

class MapCoordinator {

    func start(realm: Realm, source: MapSourceManager.Source) -> UIViewController {
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm, source: source)
        let mapOverlayProvider = MapOverlayProvider(realm: realm, source: source)
        let mapViewDelegate = MapViewDelegate()
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: mapAnnotationProvider.annotations)
        return MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                      mapOverlayProvider: mapOverlayProvider,
                                                      initialCoordinateRegion: region,
                                                      mapViewDelegate: mapViewDelegate)
    }

}
