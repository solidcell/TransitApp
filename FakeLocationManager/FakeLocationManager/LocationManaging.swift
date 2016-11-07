import CoreLocation

public protocol LocationManaging: class {

    // Supported subset interface from CLLocationManager
    weak var delegate: CLLocationManagerDelegate? { get set }
    var location: CLLocation? { get }
    func requestLocation()
    func authorizationStatus() -> CLAuthorizationStatus
    func requestWhenInUseAuthorization()
    func isLocationServicesEnabled() -> Bool
    
}
