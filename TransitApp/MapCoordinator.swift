import UIKit
import RealmSwift
import CoreLocation

class MapCoordinator {

    func start(window: UIWindow, realm: Realm) {
        let scooterWriter = ScooterWriter(realm: realm)
        let mapAnnotationDataSource = MapAnnotationDataSource(scooterWriter: scooterWriter)
        let mapAnnotationProvider = MapAnnotationProvider(dataSource: mapAnnotationDataSource)
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
        let mapViewDelegate = MapViewDelegate()
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let jsonFetcher = JSONFetcher()
        let fetchTimer = FetchTimer()
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
        let scooterUpdater = ScooterUpdater(scooterWriter: scooterWriter, scooterFetcher: scooterFetcher)
        scooterUpdater.start()
        let locationManager = CLLocationManager()
        let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapOverlayProvider: mapOverlayProvider,
                                                        initialCoordinateRegion: region,
                                                        mapViewDelegate: mapViewDelegate,
                                                        scooterUpdater: scooterUpdater,
                                                        currentLocationProvider: currentLocationProvider)
        window.rootViewController = vc
    }

}
