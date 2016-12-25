import UIKit
import MapKit
@testable import TransitApp

class SpecMapView {

    let viewModel: MapViewModel

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Input

    func tapCurrentLocationButton() {
        viewModel.tapCurrentLocationButton()
    }

    // MARK: Output

    var mapCenteredOn: CLLocationCoordinate2D?
    
}

extension SpecMapView : MapViewModelDelegate {

    func centerMap(on coordinate: CLLocationCoordinate2D) {
        mapCenteredOn = coordinate
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
                                 currentLocationProvider: CurrentLocationProvider,
                                 viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
        viewModel.delegate = mapView
    }
    
}
