import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider,
                                 viewModel: MapViewModel)
    
}

class MapViewControllerFactory : MapViewFactory {
    
    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider,
                                 viewModel: MapViewModel) {
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapOverlayProvider: mapOverlayProvider,
                                                        mapViewDelegate: mapViewDelegate,
                                                        scooterUpdater: scooterUpdater,
                                                        currentLocationProvider: currentLocationProvider,
                                                        viewModel: viewModel)
        window.rootViewController = vc
    }
    
}
