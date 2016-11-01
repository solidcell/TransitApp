import UIKit
import RealmSwift

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let source = MapSourceManager.Source.coup
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm, source: source)
        let mapOverlayProvider = MapOverlayProvider(realm: realm, source: source)
        let mapViewDelegate = MapViewDelegate()
        let mapRegionManager = MapRegionManager()
        let region = mapRegionManager.region(annotations: mapAnnotationProvider.annotations)
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapOverlayProvider: mapOverlayProvider,
                                                        initialCoordinateRegion: region,
                                                        mapViewDelegate: mapViewDelegate)
        window.rootViewController = vc
    }

}
