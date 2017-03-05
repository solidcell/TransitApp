import UIKit
import RealmSwift
import CoreLocation
import UIKitFringes

class MapCoordinator {

    func start(window: UIWindow,
               viewFactory: MapViewFactory,
               realm: Realm,
               jsonFetcher: JSONFetching,
               timerFactory: TimerFactoryProtocol,
               locationManager: LocationManaging) {
        let mapOverlayProvider = MapOverlayProvider(realm: realm)
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let timer = timerFactory.create()
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, timer: timer)
        let scooterUpdater = ScooterUpdater(scooterFetcher: scooterFetcher)
        let mapAnnotationProvider = MapAnnotationProvider(scooterUpdater: scooterUpdater)
        scooterUpdater.start()
        let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
        let currentLocationViewModel = CurrentLocationViewModel(provider: currentLocationProvider)
        let mapViewDelegate = MapViewDelegate(userTrackingModeDelegate: currentLocationViewModel)
        let viewModel = MapViewModel(currentLocationViewModel: currentLocationViewModel,
                                     initialCoordinateRegion: region,
                                     mapOverlayProvider: mapOverlayProvider,
                                     mapAnnotationProvider: mapAnnotationProvider,
                                     mapViewDelegate: mapViewDelegate)
        viewFactory.createAndAttachToWindow(window: window, viewModel: viewModel)
    }

}
