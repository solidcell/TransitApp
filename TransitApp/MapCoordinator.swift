import UIKit
import RealmSwift
import CoreLocation
import FakeLocationManager

class MapCoordinator {

    func start(window: UIWindow,
               viewFactory: MapViewFactory,
               realm: Realm,
               scooterRealmNotifier: ScooterRealmNotifier,
               jsonFetcher: JSONFetching,
               fetchTimer: FetchTiming,
               locationManager: LocationManaging) {
        let mapAnnotationDataSource = MapAnnotationDataSource(scooterRealmNotifier: scooterRealmNotifier)
        let mapAnnotationProvider = MapAnnotationProvider(dataSource: mapAnnotationDataSource)
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
        let scooterUpdater = ScooterUpdater(realm: realm, scooterFetcher: scooterFetcher)
        scooterUpdater.start()
        let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
        let viewModel = MapViewModel(currentLocationProvider: currentLocationProvider,
                                     initialCoordinateRegion: region,
                                     mapOverlayProvider: mapOverlayProvider,
                                     mapAnnotationProvider: mapAnnotationProvider,
                                     scooterUpdater: scooterUpdater)
        viewFactory.createAndAttachToWindow(window: window,
                                            viewModel: viewModel)
    }

}
