import CoreLocation

extension CLLocationManager: LocationManaging {

    // IMPORTANT: Use these instance methods instead of the
    // equivalent class methods from CLLocationManager.
    // See comments in LocationManaging for more information.
    
    public func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    public func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

}
