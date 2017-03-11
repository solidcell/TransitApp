import UIKitFringes

class MapModuleFactory {
    
    private let viewFactory: MapViewControllerFactoryProtocol
    private let jsonFetcherFactory: JSONFetcherFactory
    private let timerFactory: TimerFactoryProtocol
    private let locationManagerFactory: LocationManagingFactoryProtocol
    
    init(viewFactory: MapViewControllerFactoryProtocol,
         jsonFetcherFactory: JSONFetcherFactory,
         timerFactory: TimerFactoryProtocol,
         locationManagerFactory: LocationManagingFactoryProtocol) {
        self.viewFactory = viewFactory
        self.jsonFetcherFactory = jsonFetcherFactory
        self.timerFactory = timerFactory
        self.locationManagerFactory = locationManagerFactory
    }

    func create() -> MapViewControlling {
        let businessAreas = SeedDataParser().businessAreas
        let mapOverlayProvider = MapOverlayProvider(businessAreas: businessAreas)
        let mapRegionProvider = MapRegionProvider()
        let region = mapRegionProvider.region
        let timer = timerFactory.create()
        let jsonFetcher = jsonFetcherFactory.create()
        let scooterFetcher = ScooterFetcher(jsonFetcher: jsonFetcher, timer: timer)
        let scooterUpdater = ScooterUpdater(scooterFetcher: scooterFetcher)
        let mapAnnotationProvider = MapAnnotationProvider(scooterUpdater: scooterUpdater)
        scooterUpdater.start()
        let locationManager = locationManagerFactory.create()
        let currentLocationProvider = CurrentLocationProvider(locationManager: locationManager)
        let currentLocationViewModel = CurrentLocationViewModel(provider: currentLocationProvider)
        let mapViewDelegate = MapViewDelegate(userTrackingModeDelegate: currentLocationViewModel)
        let presenter = MapPresenter(currentLocationViewModel: currentLocationViewModel,
                                     initialCoordinateRegion: region,
                                     mapOverlayProvider: mapOverlayProvider,
                                     mapAnnotationProvider: mapAnnotationProvider,
                                     mapViewDelegate: mapViewDelegate)
        let viewController = viewFactory.create()
        viewController.presenter = presenter
        return viewController
    }
}
