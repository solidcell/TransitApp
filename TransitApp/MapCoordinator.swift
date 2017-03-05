import UIKit

import CoreLocation
import UIKitFringes

class MapCoordinatorFactory {
    
    private let viewFactory: MapViewFactory
    private let jsonFetcher: JSONFetching
    private let timerFactory: TimerFactoryProtocol
    private let locationManagerFactory: LocationManagingFactoryProtocol

    init(viewFactory: MapViewFactory,
         jsonFetcher: JSONFetching,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        self.viewFactory = viewFactory
        self.jsonFetcher = jsonFetcher
        self.timerFactory = timerFactory
        self.locationManagerFactory = locationManagerFactory
    }

    func create() -> MapCoordinator {
        return MapCoordinator(viewFactory: viewFactory,
                              jsonFetcher: jsonFetcher,
                              timerFactory: timerFactory,
                              locationManagerFactory: locationManagerFactory)
    }
}

class MapCoordinator {
    
    private let viewFactory: MapViewFactory
    private let jsonFetcher: JSONFetching
    private let timerFactory: TimerFactoryProtocol
    private let locationManagerFactory: LocationManagingFactoryProtocol
    
    init(viewFactory: MapViewFactory,
         jsonFetcher: JSONFetching,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        self.viewFactory = viewFactory
        self.jsonFetcher = jsonFetcher
        self.timerFactory = timerFactory
        self.locationManagerFactory = locationManagerFactory
    }

    func start(window: UIWindow) {
        let businessAreas = SeedDataParser().businessAreas
        let mapOverlayProvider = MapOverlayProvider(businessAreas: businessAreas)
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let timer = timerFactory.create()
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, timer: timer)
        let scooterUpdater = ScooterUpdater(scooterFetcher: scooterFetcher)
        let mapAnnotationProvider = MapAnnotationProvider(scooterUpdater: scooterUpdater)
        scooterUpdater.start()
        let locationManager = locationManagerFactory.create()
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
