import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 initialCoordinateRegion: MKCoordinateRegion,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider)
    
}

class MapViewControllerFactory : MapViewFactory {
    
    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 initialCoordinateRegion: MKCoordinateRegion,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider) {
        let vc = MapViewController.createFromStoryboard(mapAnnotationProvider: mapAnnotationProvider,
                                                        mapOverlayProvider: mapOverlayProvider,
                                                        initialCoordinateRegion: initialCoordinateRegion,
                                                        mapViewDelegate: mapViewDelegate,
                                                        scooterUpdater: scooterUpdater,
                                                        currentLocationProvider: currentLocationProvider)
        window.rootViewController = vc
    }
    
}
