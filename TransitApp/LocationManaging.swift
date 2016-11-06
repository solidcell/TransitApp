import CoreLocation

extension CLLocationManager: LocationManaging {

    /*
     Expose these methods via instances, since they need to be testable.
     If they were class functions, in SpecLocationManager their backing
     variables would need to be class variables, be Swift doesn't support
     class variables, so they would have to be static, but static won't
     reset itself between tests, so the values would pollute other tests.
     */
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

}

protocol LocationManaging: class {

    // Supported subset interface from CLLocationManager
    weak var delegate: CLLocationManagerDelegate? { get set }
    var location: CLLocation? { get }
    func requestLocation()
    func authorizationStatus() -> CLAuthorizationStatus
    func requestWhenInUseAuthorization()
    func isLocationServicesEnabled() -> Bool
    
}
