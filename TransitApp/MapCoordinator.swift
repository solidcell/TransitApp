import UIKit
import RealmSwift

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let mapAnnotationDataSource = MapAnnotationDataSource(results: realm.scooters)
        let mapAnnotationProvider = MapAnnotationProvider(dataSource: mapAnnotationDataSource)
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
        let mapViewDelegate = MapViewDelegate()
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let jsonFetcher = JSONFetcher()
        let fetchTimer = FetchTimer()
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
        let scooterUpdater = ScooterUpdater(realm: realm, scooterFetcher: scooterFetcher)
        scooterUpdater.start()
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapOverlayProvider: mapOverlayProvider,
                                                        initialCoordinateRegion: region,
                                                        mapViewDelegate: mapViewDelegate,
                                                        scooterUpdater: scooterUpdater)
        window.rootViewController = vc
    }

}
