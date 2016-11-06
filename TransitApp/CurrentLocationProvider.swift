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
            getCurrentLocationIfAuthorized()
        }
    }

    fileprivate func getCurrentLocationIfAuthorized() {
        if !authorized { return }

        if let location = locationManager.location {
            updateDelegateWithLocation(location)
        } else {
            locationManager.requestLocation()
        }
    }

    fileprivate var authorized: Bool {
        return locationManager.authorizationStatus().isOneOf(.authorizedWhenInUse, .authorizedAlways)
    }

    fileprivate func updateDelegateWithLocation(_ location: CLLocation) {
        delegate?.currentLocation(location)
    }
    
}

extension CurrentLocationProvider: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDelegateWithLocation(locations.last!)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // This can happen when location was requested, but could not be determined, for instance.
        // We should probably implement some kind of notification for the user, like a banner notice.
        fatalError("Implement some behavior for this when the time comes")
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        getCurrentLocationIfAuthorized()
    }

}

protocol CurrentLocationProviderDelegate: class {

    func currentLocation(_ location: CLLocation)
    
}
