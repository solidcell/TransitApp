import CoreLocation

public protocol LocationManagingFactoryProtocol {

    func create() -> LocationManaging
}

public class CLLocationManagerFactory: LocationManagingFactoryProtocol {

    public init() { }

    public func create() -> LocationManaging {
        return CLLocationManager()
    }
}

public protocol LocationManaging: class {

    /*
     IMPORTANT: Use these instance methods instead of the equivalent
     class methods from CLLocationManager.

     These methods are exposed as instance methods, since they need
     to be testable. If they were left as class methods, in
     SpecLocationManager their backing variables would need to be
     class variables, be Swift doesn't support class variables, so
     they would have to be static, but static won't reset itself
     between tests, so the values would pollute other tests.

     Ensure that you do not cast to CLLocationManager and you will
     Not have access to the original class methods, and you'll be fine.
     */
    func authorizationStatus() -> CLAuthorizationStatus
    func isLocationServicesEnabled() -> Bool

    // Supported subset interface from CLLocationManager
    weak var delegate: CLLocationManagerDelegate? { get set }
    var location: CLLocation? { get }
    func requestLocation()
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    
}
extension CLLocationManager: LocationManaging {
    
    public func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    public func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

}
