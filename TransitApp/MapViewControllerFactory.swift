import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 viewModel: MapViewModel)
    
}

class MapViewControllerFactory : MapViewFactory {
    
    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 viewModel: MapViewModel) {
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapViewDelegate: mapViewDelegate,
                                                        scooterUpdater: scooterUpdater,
                                                        viewModel: viewModel)
        window.rootViewController = vc
    }
    
}
