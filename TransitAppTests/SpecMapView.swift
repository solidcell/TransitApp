import UIKit
import MapKit
@testable import TransitApp

class SpecMapView {

    let viewModel: MapViewModel

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        // the following could be moved/removed if RxSwift
        // were used. Some other way without it?
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    // MARK: Input

    func tapCurrentLocationButton() {
        viewModel.tapCurrentLocationButton()
    }

    // MARK: Output

    var mapCenteredOn: CLLocationCoordinate2D?
    var mapRegion: MKCoordinateRegion?
    
}

extension SpecMapView : MapViewModelDelegate {

    func centerMap(on coordinate: CLLocationCoordinate2D) {
        mapCenteredOn = coordinate
    }

    func setRegion(_ region: MKCoordinateRegion) {
        self.mapRegion = region
    }

}

class SpecMapViewFactory : MapViewFactory {

    var mapView: SpecMapView!

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 mapOverlayProvider: MapOverlayProvider,
                                 mapViewDelegate: MKMapViewDelegate,
                                 scooterUpdater: ScooterUpdater,
                                 currentLocationProvider: CurrentLocationProvider,
                                 viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
    }
    
}
