import UIKit
import RealmSwift

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let mapAnnotationProvider = MapAnnotationProvider(realm: realm)
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
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
