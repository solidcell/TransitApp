import CoreLocation
import MapKit

class MapViewModel {
    
    private let currentLocationProvider: CurrentLocationProvider
    private let initialCoordinateRegion: MKCoordinateRegion
    private let mapOverlayProvider: MapOverlayProvider
    var delegate: MapViewModelDelegate!

    init(currentLocationProvider: CurrentLocationProvider,
         initialCoordinateRegion: MKCoordinateRegion,
         mapOverlayProvider: MapOverlayProvider) {
        self.currentLocationProvider = currentLocationProvider
        self.initialCoordinateRegion = initialCoordinateRegion
        self.mapOverlayProvider = mapOverlayProvider
        currentLocationProvider.delegate = self
    }

    func viewDidLoad() {
        delegate.setOverlays(mapOverlayProvider.overlays)
        delegate.setRegion(initialCoordinateRegion)
    }

    func tapCurrentLocationButton() {
        currentLocationProvider.getCurrentLocation()
    }
    
}

extension MapViewModel : CurrentLocationProviderDelegate {

    func currentLocation(_ location: CLLocation) {
        delegate.centerMap(on: location.coordinate)
    }
    
}

protocol MapViewModelDelegate {

    func centerMap(on: CLLocationCoordinate2D)
    func setRegion(_ region: MKCoordinateRegion)
    func setOverlays(_ overlays: [MKOverlay])
    
}
