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
    var mapOverlays = [MKOverlay]()
    
}

extension SpecMapView : MapViewModelDelegate {

    func centerMap(on coordinate: CLLocationCoordinate2D) {
        self.mapCenteredOn = coordinate
    }

    func setRegion(_ region: MKCoordinateRegion) {
        self.mapRegion = region
    }

    func setOverlays(_ overlays: [MKOverlay]) {
        self.mapOverlays = overlays
    }

}

class SpecMapViewFactory : MapViewFactory {

    var mapView: SpecMapView!

    func createAndAttachToWindow(window: UIWindow,
                                 mapAnnotationProvider: MapAnnotationProvider,
                                 scooterUpdater: ScooterUpdater,
                                 viewModel: MapViewModel) {
        mapView = SpecMapView(viewModel: viewModel)
    }
    
}
