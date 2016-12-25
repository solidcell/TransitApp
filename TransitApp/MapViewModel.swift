import CoreLocation

class MapViewModel {
    
    private let currentLocationProvider: CurrentLocationProvider
    var delegate: MapViewModelDelegate!

    init(currentLocationProvider: CurrentLocationProvider) {
        self.currentLocationProvider = currentLocationProvider
        currentLocationProvider.delegate = self
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
    
}
