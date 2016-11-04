import CoreLocation

extension CLLocationManager: LocationManaging {

    // Expose it only via instances, since it needs to be testable.
    // If it were a class variable, Swift doesn't support class 
    // variables, so it would have to be static, but static won't
    // reset itself between tests, so it would pollute other tests
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
}

protocol LocationManaging: class {

    // Supported subset interface from CLLocationManager
    weak var delegate: CLLocationManagerDelegate? { get set }
    func requestLocation()
    func authorizationStatus() -> CLAuthorizationStatus
    
}
