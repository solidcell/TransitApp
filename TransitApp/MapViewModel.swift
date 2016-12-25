import CoreLocation
import MapKit

class MapViewModel {
    
    private let currentLocationProvider: CurrentLocationProvider
    private let initialCoordinateRegion: MKCoordinateRegion
    var delegate: MapViewModelDelegate!

    init(currentLocationProvider: CurrentLocationProvider,
         initialCoordinateRegion: MKCoordinateRegion) {
        self.currentLocationProvider = currentLocationProvider
        self.initialCoordinateRegion = initialCoordinateRegion
        currentLocationProvider.delegate = self
    }

    func viewDidLoad() {
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
    
}
