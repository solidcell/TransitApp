import UIKit
import MapKit
@testable import TransitApp

class SpecMapView {

    let currentLocationProvider: CurrentLocationProvider

    init(currentLocationProvider: CurrentLocationProvider) {
        self.currentLocationProvider = currentLocationProvider
    }

    // MARK: Input

    func tapCurrentLocationButton() {
        currentLocationProvider.getCurrentLocation()
    }
    
}

class SpecMapViewFactory : MapViewFactory {

    var mapView: SpecMapView!

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 initialCoordinateRegion: MKCoordinateRegion,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider) {
        mapView = SpecMapView(currentLocationProvider: currentLocationProvider)
    }
    
}
