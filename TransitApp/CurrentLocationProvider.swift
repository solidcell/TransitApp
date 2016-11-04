import CoreLocation

// This class wraps CLLocationManager interaction

class CurrentLocationProvider: NSObject {

    weak var delegate: CurrentLocationProviderDelegate?
    fileprivate let locationManager: LocationManaging
    
    init(locationManager: LocationManaging) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    func getCurrentLocation() {
        if !authorized {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }

    fileprivate var authorized: Bool {
        return locationManager.authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways)
    }
    
}

extension CurrentLocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.currentLocation(locations.first!)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        fatalError("We should try to have this never called. Investigate it.")
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if authorized {
            locationManager.requestLocation()
        }
    }

}

protocol CurrentLocationProviderDelegate: class {

    func currentLocation(_ location: CLLocation)
    
}
