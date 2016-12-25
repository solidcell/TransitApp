import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 scooterUpdater: ScooterUpdater,
                                 viewModel: MapViewModel)
    
}

class MapViewControllerFactory : MapViewFactory {
    
    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 scooterUpdater: ScooterUpdater,
                                 viewModel: MapViewModel) {
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        scooterUpdater: scooterUpdater,
                                                        viewModel: viewModel)
        window.rootViewController = vc
    }
    
}
