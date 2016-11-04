import CoreLocation

// This class wraps CLLocationManager interaction

class CurrentLocationProvider: NSObject {

    weak var delegate: CurrentLocationProviderDelegate?
    private let locationManager: LocationManaging
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
}

extension CurrentLocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.currentLocation(locations.first!)
    }

}

protocol CurrentLocationProviderDelegate: class {

    func currentLocation(_ location: CLLocation)
    
}
