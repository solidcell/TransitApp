import UIKit
import RealmSwift
import CoreLocation

class MapCoordinator {

    func start(window: UIWindow,
               realm: Realm,
               scooterRealmNotifier: ScooterRealmNotifier,
               jsonFetcher: JSONFetcher,
               fetchTimer: FetchTimer) {
        let mapAnnotationDataSource = MapAnnotationDataSource(scooterRealmNotifier: scooterRealmNotifier)
        let mapAnnotationProvider = MapAnnotationProvider(dataSource: mapAnnotationDataSource)
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
        let mapViewDelegate = MapViewDelegate()
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
        let scooterUpdater = ScooterUpdater(realm: realm, scooterFetcher: scooterFetcher)
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
